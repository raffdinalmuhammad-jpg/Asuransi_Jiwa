package koneksi;

import java.security.SecureRandom;
import java.security.MessageDigest;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {
    private static final int ITERATIONS = 210000;
    private PasswordUtil() {}
    public static String hash(String password) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        byte[] derived = derive(password, salt, ITERATIONS);
        return "pbkdf2:" + ITERATIONS + ":" + Base64.getEncoder().encodeToString(salt) + ":" + Base64.getEncoder().encodeToString(derived);
    }
    private static byte[] derive(String password, byte[] salt, int iterations) throws Exception {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, iterations, 256);
        try { return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded(); }
        finally { spec.clearPassword(); }
    }
    public static boolean matches(String password, String stored) throws Exception {
        if (stored == null) return false;
        if (!stored.startsWith("pbkdf2:")) {
            // Kompatibilitas sementara untuk akun lama dari SQL awal.
            return MessageDigest.isEqual(password.getBytes("UTF-8"), stored.getBytes("UTF-8"));
        }
        String[] fields = stored.split(":", 4);
        if (fields.length != 4) return false;
        int rounds = Integer.parseInt(fields[1]);
        if (rounds < 10000 || rounds > 1000000) return false;
        byte[] actual = Base64.getDecoder().decode(fields[3]);
        byte[] expected = derive(password, Base64.getDecoder().decode(fields[2]), rounds);
        return MessageDigest.isEqual(expected, actual);
    }
}

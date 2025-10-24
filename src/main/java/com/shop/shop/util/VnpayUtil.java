package com.shop.shop.util;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class VnpayUtil {

    public static String hmacSHA512(String key, String data) throws Exception {
        Mac hmac512 = Mac.getInstance("HmacSHA512");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        hmac512.init(secretKey);
        byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    /**
     * Build string for hash: join key=value with '&' using raw values (no
     * URL-encoding). The map must contain only vnp_... keys already filtered.
     */
    public static String buildHashData(Map<String, String> params) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < fieldNames.size(); i++) {
            String k = fieldNames.get(i);
            String v = params.get(k);
            if (v == null || v.isEmpty()) {
                continue;
            }
            sb.append(k).append("=").append(v);
            if (i < fieldNames.size() - 1) {
                sb.append("&");
            }
        }
        return sb.toString();
    }

    /**
     * Build URL query string (URL-encode values)
     */
    public static String buildQueryString(Map<String, String> params) throws Exception {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < fieldNames.size(); i++) {
            String k = fieldNames.get(i);
            String v = params.get(k);
            if (v == null || v.isEmpty()) {
                continue;
            }
            sb.append(URLEncoder.encode(k, StandardCharsets.UTF_8.toString()));
            sb.append("=");
            sb.append(URLEncoder.encode(v, StandardCharsets.UTF_8.toString()));
            if (i < fieldNames.size() - 1) {
                sb.append("&");
            }
        }
        return sb.toString();
    }
}

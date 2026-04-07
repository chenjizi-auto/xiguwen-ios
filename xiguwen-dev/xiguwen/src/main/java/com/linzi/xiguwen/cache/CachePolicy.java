package com.linzi.xiguwen.cache;

public final class CachePolicy {
    public static final long TTL_REGION = 7L * 24 * 60 * 60 * 1000;
    public static final long TTL_DICT = 3L * 24 * 60 * 60 * 1000;
    public static final long TTL_CONFIG = 24L * 60 * 60 * 1000;

    private CachePolicy() {
    }
}

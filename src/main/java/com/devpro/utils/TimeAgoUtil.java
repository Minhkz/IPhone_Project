package com.devpro.utils;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class TimeAgoUtil {

    public static String toTimeAgo(LocalDateTime createdAt) {
        LocalDateTime now = LocalDateTime.now();

        long seconds = ChronoUnit.SECONDS.between(createdAt, now);
        long minutes = ChronoUnit.MINUTES.between(createdAt, now);
        long hours = ChronoUnit.HOURS.between(createdAt, now);
        long days = ChronoUnit.DAYS.between(createdAt, now);

        if (seconds < 60) {
            return "Vừa xong";
        } else if (minutes < 60) {
            return minutes + " phút trước";
        } else if (hours < 24) {
            return hours + " giờ trước";
        } else if (days < 7) {
            return days + " ngày trước";
        } else if (days < 30) {
            return (days / 7) + " tuần trước";
        } else if (days < 365) {
            return (days / 30) + " tháng trước";
        } else {
            return (days / 365) + " năm trước";
        }
    }
}

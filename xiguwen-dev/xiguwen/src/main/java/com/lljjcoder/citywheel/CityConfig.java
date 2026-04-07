package com.lljjcoder.citywheel;

public class CityConfig {
    public enum WheelType {
        PRO,
        PRO_CITY,
        PRO_CITY_DIS
    }

    private WheelType cityWheelType;
    private String defaultProvinceName;
    private String defaultCityName;
    private String defaultDistrict;

    private CityConfig(Builder builder) {
        this.cityWheelType = builder.cityWheelType;
        this.defaultProvinceName = builder.defaultProvinceName;
        this.defaultCityName = builder.defaultCityName;
        this.defaultDistrict = builder.defaultDistrict;
    }

    public WheelType getCityWheelType() {
        return cityWheelType;
    }

    public void setCityWheelType(WheelType cityWheelType) {
        this.cityWheelType = cityWheelType;
    }

    public String getDefaultProvinceName() {
        return defaultProvinceName;
    }

    public void setDefaultProvinceName(String defaultProvinceName) {
        this.defaultProvinceName = defaultProvinceName;
    }

    public String getDefaultCityName() {
        return defaultCityName;
    }

    public void setDefaultCityName(String defaultCityName) {
        this.defaultCityName = defaultCityName;
    }

    public String getDefaultDistrict() {
        return defaultDistrict;
    }

    public void setDefaultDistrict(String defaultDistrict) {
        this.defaultDistrict = defaultDistrict;
    }

    public static class Builder {
        private WheelType cityWheelType = WheelType.PRO_CITY_DIS;
        private String defaultProvinceName = "四川省";
        private String defaultCityName = "成都市";
        private String defaultDistrict = "武侯区";

        public Builder setCityWheelType(WheelType cityWheelType) {
            this.cityWheelType = cityWheelType;
            return this;
        }

        public Builder setDefaultProvinceName(String defaultProvinceName) {
            this.defaultProvinceName = defaultProvinceName;
            return this;
        }

        public Builder setDefaultCityName(String defaultCityName) {
            this.defaultCityName = defaultCityName;
            return this;
        }

        public Builder setDefaultDistrict(String defaultDistrict) {
            this.defaultDistrict = defaultDistrict;
            return this;
        }

        public CityConfig build() {
            return new CityConfig(this);
        }
    }
}

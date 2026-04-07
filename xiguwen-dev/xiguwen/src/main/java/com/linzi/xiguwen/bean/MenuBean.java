package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by jiang on 2017/11/21.
 */

public class MenuBean implements Serializable {
    private List<Menu> menus;

    public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }

    public static class Menu implements Serializable {
        @Override
        public String toString() {
            return "Menu{" +
                    "id=" + id +
                    ", icon='" + icon + '\'' +
                    ", title='" + title + '\'' +
                    '}';
        }

        private int id;
        private String icon;
        private String title;

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getIcon() {
            return icon;
        }

        public void setIcon(String icon) {
            this.icon = icon;
        }
    }
}

package com.example.zhouwei.library;

import android.content.Context;
import android.view.View;
import android.widget.PopupWindow;

import com.linzi.xiguwen.fragment.search.MyPopWindow;

public class CustomPopWindow {
    private final MyPopWindow delegate;

    private CustomPopWindow(MyPopWindow delegate) {
        this.delegate = delegate;
    }

    public int getWidth() {
        return delegate.getWidth();
    }

    public int getHeight() {
        return delegate.getHeight();
    }

    public CustomPopWindow showAsDropDown(View anchor, int xOff, int yOff) {
        delegate.showAsDropDown(anchor, xOff, yOff);
        return this;
    }

    public CustomPopWindow showAsDropDown(View anchor) {
        delegate.showAsDropDown(anchor);
        return this;
    }

    public CustomPopWindow showAsDropDown(View anchor, int xOff, int yOff, int gravity) {
        delegate.showAsDropDown(anchor, xOff, yOff, gravity);
        return this;
    }

    public CustomPopWindow showAtLocation(View parent, int gravity, int x, int y) {
        delegate.showAtLocation(parent, gravity, x, y);
        return this;
    }

    public void dissmiss() {
        delegate.dissmiss();
    }

    public PopupWindow getPopupWindow() {
        return delegate.getPopupWindow();
    }

    public static class PopupWindowBuilder {
        private final MyPopWindow.PopupWindowBuilder delegateBuilder;

        public PopupWindowBuilder(Context context) {
            delegateBuilder = new MyPopWindow.PopupWindowBuilder(context);
        }

        public PopupWindowBuilder size(int width, int height) {
            delegateBuilder.size(width, height);
            return this;
        }

        public PopupWindowBuilder setFocusable(boolean focusable) {
            delegateBuilder.setFocusable(focusable);
            return this;
        }

        public PopupWindowBuilder setView(int resLayoutId) {
            delegateBuilder.setView(resLayoutId);
            return this;
        }

        public PopupWindowBuilder setView(View view) {
            delegateBuilder.setView(view);
            return this;
        }

        public PopupWindowBuilder setOutsideTouchable(boolean outsideTouchable) {
            delegateBuilder.setOutsideTouchable(outsideTouchable);
            return this;
        }

        public PopupWindowBuilder setAnimationStyle(int animationStyle) {
            delegateBuilder.setAnimationStyle(animationStyle);
            return this;
        }

        public PopupWindowBuilder setClippingEnable(boolean enable) {
            delegateBuilder.setClippingEnable(enable);
            return this;
        }

        public PopupWindowBuilder setIgnoreCheekPress(boolean ignoreCheekPress) {
            delegateBuilder.setIgnoreCheekPress(ignoreCheekPress);
            return this;
        }

        public PopupWindowBuilder setInputMethodMode(int mode) {
            delegateBuilder.setInputMethodMode(mode);
            return this;
        }

        public PopupWindowBuilder setOnDissmissListener(PopupWindow.OnDismissListener onDissmissListener) {
            delegateBuilder.setOnDissmissListener(onDissmissListener);
            return this;
        }

        public PopupWindowBuilder setSoftInputMode(int softInputMode) {
            delegateBuilder.setSoftInputMode(softInputMode);
            return this;
        }

        public PopupWindowBuilder setTouchable(boolean touchable) {
            delegateBuilder.setTouchable(touchable);
            return this;
        }

        public PopupWindowBuilder setTouchIntercepter(View.OnTouchListener touchIntercepter) {
            delegateBuilder.setTouchIntercepter(touchIntercepter);
            return this;
        }

        public PopupWindowBuilder enableBackgroundDark(boolean isDark) {
            delegateBuilder.enableBackgroundDark(isDark);
            return this;
        }

        public PopupWindowBuilder setBgDarkAlpha(float darkValue) {
            delegateBuilder.setBgDarkAlpha(darkValue);
            return this;
        }

        public PopupWindowBuilder enableOutsideTouchableDissmiss(boolean disMiss) {
            delegateBuilder.enableOutsideTouchableDissmiss(disMiss);
            return this;
        }

        public CustomPopWindow create() {
            return new CustomPopWindow(delegateBuilder.create());
        }
    }
}

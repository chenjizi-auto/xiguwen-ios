package com.linzi.xiguwen.adapter;


import androidx.cardview.widget.CardView;

public interface CardAdapter {

    int MAX_ELEVATION_FACTOR = 20;

    float getBaseElevation();

    CardView getCardViewAt(int position);

    int getCount();
}

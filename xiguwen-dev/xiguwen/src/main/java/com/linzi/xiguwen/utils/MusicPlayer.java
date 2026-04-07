package com.linzi.xiguwen.utils;

import android.content.Context;
import android.media.MediaPlayer;

import com.linzi.xiguwen.bean.MusicBean;
import com.netease.nimlib.sdk.media.player.AudioPlayer;

import java.io.IOException;

/**
 * Created by PC on 2018-04-09.
 */

public class MusicPlayer implements MediaPlayer.OnPreparedListener, MediaPlayer.OnErrorListener, MediaPlayer.OnCompletionListener {

    private MediaPlayer mPlayer;
    private boolean mIsPlayCompletion = true; // 是否播放完成的标记

    public MusicPlayer(){
        mPlayer = new MediaPlayer();
        mPlayer.setOnPreparedListener(this);
        mPlayer.setOnErrorListener(this);
        mPlayer.setOnCompletionListener(this);
    }

    public void play(MusicBean.DataBean musicBean){
        mPlayer.stop();
        mPlayer.reset();
        try {
            mPlayer.setDataSource(musicBean.getUrl());
            mPlayer.prepareAsync();
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            NToast.show("播放失败");
        }
    }

    public void play(){
        if(!mIsPlayCompletion){
            // 未完成才继续播放
            mPlayer.start();
        }
    }

    public void pause(){
        mPlayer.pause();
    }

    public void stop(){
        mPlayer.stop();
        mPlayer.reset();
    }

    public void release(){
        if(!mIsPlayCompletion){
            mPlayer.stop();
        }
        mPlayer.release();
        mPlayer = null;
    }

    @Override
    public void onPrepared(MediaPlayer mp) {
        // 准备完成，则开始播放
        mIsPlayCompletion = false;
        mp.start();
    }

    @Override
    public boolean onError(MediaPlayer mp, int what, int extra) {
        if(!mIsPlayCompletion){
            NToast.show("播放异常");
            mIsPlayCompletion = true;
        }
        stop();
        return false;
    }

    @Override
    public void onCompletion(MediaPlayer mp) {
        //播放完成
        mIsPlayCompletion = true;
    }
}

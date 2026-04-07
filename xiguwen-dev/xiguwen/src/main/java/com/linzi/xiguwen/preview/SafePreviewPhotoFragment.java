package com.linzi.xiguwen.preview;

import com.previewlibrary.view.BasePhotoFragment;

/**
 * Guard ImagePreview 2.1.8 PhotoViewAttacher null crash during fragment/activity destroy.
 */
public class SafePreviewPhotoFragment extends BasePhotoFragment {

    @Override
    public void release() {
        mySimpleTarget = null;
        if (imageView != null) {
            imageView.setImageBitmap(null);

            // PhotoViewAttacher may already be cleaned up in onDetachedFromWindow.
            if (imageView.getIPhotoViewImplementation() != null) {
                imageView.setOnViewTapListener(null);
                imageView.setOnPhotoTapListener(null);
                imageView.setOnLongClickListener(null);
            }

            imageView.setAlphaChangeListener(null);
            imageView.setTransformOutListener(null);
            imageView.transformIn(null);
            imageView.transformOut(null);
        }

        if (btnVideo != null) {
            btnVideo.setOnClickListener(null);
        }

        imageView = null;
        rootView = null;
        listener = null;
    }
}

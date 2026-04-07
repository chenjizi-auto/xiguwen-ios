package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.LogFileManager;
import com.linzi.xiguwen.utils.NToast;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class LogCenterActivity extends AppCompatActivity {
    private TextView tvPath;
    private ListView listView;
    private final List<File> logFiles = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_log_center);

        ImageView ivBack = findViewById(R.id.iv_back);
        TextView tvShare = findViewById(R.id.tv_share);
        tvPath = findViewById(R.id.tv_path);
        listView = findViewById(R.id.list_logs);

        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        tvShare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (logFiles.isEmpty()) {
                    NToast.show("暂无日志");
                    return;
                }
                shareFile(logFiles.get(0));
            }
        });

        loadLogs();

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                shareFile(logFiles.get(position));
            }
        });
    }

    private void loadLogs() {
        File dir = LogFileManager.ensureLogDir(this);
        tvPath.setText(dir.getAbsolutePath());
        File[] files = dir.listFiles();
        logFiles.clear();
        if (files != null) {
            Arrays.sort(files, new Comparator<File>() {
                @Override
                public int compare(File o1, File o2) {
                    return Long.compare(o2.lastModified(), o1.lastModified());
                }
            });
            logFiles.addAll(Arrays.asList(files));
        }

        List<String> names = new ArrayList<>();
        for (File f : logFiles) {
            names.add(f.getName());
        }
        listView.setAdapter(new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, names));
    }

    private void shareFile(File file) {
        try {
            Uri uri = FileProvider.getUriForFile(this, "com.linzi.xiguwen.fileProvider", file);
            Intent intent = new Intent(Intent.ACTION_SEND);
            intent.setType("text/plain");
            intent.putExtra(Intent.EXTRA_STREAM, uri);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            startActivity(Intent.createChooser(intent, "分享日志"));
        } catch (Exception e) {
            NToast.show("分享失败");
        }
    }
}

package a406.kingmaker.kingmaker;

import io.flutter.embedding.android.FlutterActivity;
import android.content.Context;
import androidx.multidex.MultiDex;

public class MainActivity extends FlutterActivity {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}

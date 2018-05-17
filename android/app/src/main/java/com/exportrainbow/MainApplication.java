package com.exportrainbow;

import android.graphics.Color;

import com.ale.rainbowsdk.RainbowSdk;
import com.exportrainbow.RainbowManager.RainbowManagerPackage;
import com.facebook.react.ReactApplication;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;

import java.util.Arrays;
import java.util.List;

public class MainApplication extends android.support.multidex.MultiDexApplication implements ReactApplication {

  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    public boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
              new RainbowManagerPackage()
      );
    }

    @Override
    protected String getJSMainModuleName() {
      return "index";
    }
  };

  @Override
  public ReactNativeHost getReactNativeHost() {
    return mReactNativeHost;
  }

  @Override
  public void onCreate() {
    super.onCreate();
    SoLoader.init(this, /* native exopackage */ false);
      RainbowSdk.instance().setNotificationBuilder(getApplicationContext(),
              MainActivity.class,
              R.drawable.default_contact,
              getString(R.string.app_name),
              "Export Rainbow",
              Color.RED);
      RainbowSdk.instance().initialize();
  }
}

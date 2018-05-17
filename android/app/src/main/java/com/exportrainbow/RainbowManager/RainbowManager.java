package com.exportrainbow.RainbowManager;

import android.content.Context;
import android.util.Log;

import com.ale.listener.SigninResponseListener;
import com.ale.listener.SignoutResponseListener;
import com.ale.listener.StartResponseListener;
import com.ale.rainbowsdk.RainbowSdk;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

public class RainbowManager extends ReactContextBaseJavaModule {
    String TAG = "HuyLHLog-RainbowManager";
    MainController mainController;

    Context mContext;

    public RainbowManager(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;

    }

    @ReactMethod
    public void addEvent(String name, String location, int date) {
        Log.d(TAG, "addEvent: name - location - date" + name + location + date);
        WritableMap params = Arguments.createMap();
        params.putString("event", EventName.didLoginRainbow);
        sendEvent((ReactContext) mContext, EventName.didLoginRainbow, params);
    }

    @ReactMethod
    public void getContactList(Callback callback) {
        Log.d(TAG, "getContactList: ");
        Log.d(TAG, "getContactList: " + mainController.getContactList().getCount());
        callback.invoke(HelperMethods.JSONFromContacts(mainController.getContactList()));
    }

    @ReactMethod
    public void loginWith(String userName, String password) {
        Log.d(TAG, "loginWith: usrName - password: " + userName + " - " + password);
        RainbowSdk.instance().connection().start(new StartResponseListener() {
            @Override
            public void onStartSucceeded() {
                Log.d(TAG, "onStartSucceeded: ");
                RainbowSdk.instance().connection().signin(userName, password, new SigninResponseListener() {
                    @Override
                    public void onSigninSucceeded() {
                        Log.d(TAG, "onSigninSucceeded:");
                        sendEvent((ReactContext) mContext, EventName.didLoginRainbow, null);
                        generateMainController();
                    }

                    @Override
                    public void onRequestFailed(RainbowSdk.ErrorCode errorCode, String s) {
                        Log.d(TAG, "onRequestFailed: "+ s);
                        sendEvent((ReactContext) mContext, EventName.failAuthenticationRainbow, null);
                    }
                });
            }

            @Override
            public void onRequestFailed(RainbowSdk.ErrorCode errorCode, String s) {
                Log.d(TAG, "onRequestFailed: " + s);
                sendEvent((ReactContext) mContext, EventName.failToStartRainbowService, null);
            }
        });
    }

    @ReactMethod
    public void logOut() {
        Log.d(TAG, "logOut:");
        RainbowSdk.instance().connection().signout(new SignoutResponseListener() {
            @Override
            public void onSignoutSucceeded() {
                sendEvent((ReactContext) mContext, EventName.didLogoutRainbow, null);
                Log.d(TAG, "onSignoutSucceeded:");
            }

            @Override
            public void onRequestFailed(RainbowSdk.ErrorCode errorCode, String s) {
                com.ale.util.log.Log.getLogger().info(TAG, "Failed to signout");
            }
        });
    }

    @ReactMethod
    public void getConversations(Callback callback) {
        Log.d(TAG, "getConversations: ");
        Log.d(TAG, "getConversations: " + mainController.getConversations().getCount());
        callback.invoke(HelperMethods.JSONFromConversations(mainController.getConversations()));
    }

    private void generateMainController() {
        mainController = new MainController();
    }

    private void sendEvent(ReactContext reactContext,
                           String eventName,
                           @Nullable WritableMap params) {
        reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    @Override
    public String getName() {
        return "RainbowManager";
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put(EventName.didAddCall, EventName.didAddCall);
        constants.put(EventName.didAddedCachedItems, EventName.didAddedCachedItems);
        constants.put(EventName.didAllowMicrophone, EventName.didAllowMicrophone);
        constants.put(EventName.didChangeCallStatus, EventName.didChangeCallStatus);
        constants.put(EventName.didEndPopulatingRainbow, EventName.didEndPopulatingRainbow);
        constants.put(EventName.didLoginRainbow, EventName.didLoginRainbow);
        constants.put(EventName.didLogoutRainbow, EventName.didLogoutRainbow);
        constants.put(EventName.didRemoveCacheItems, EventName.didRemoveCacheItems);
        constants.put(EventName.didRemoveCall, EventName.didRemoveCall);
        constants.put(EventName.didRemoveMicrophone, EventName.didRemoveMicrophone);
        constants.put(EventName.didReorderCacheItemsAtIndexes, EventName.didReorderCacheItemsAtIndexes);
        constants.put(EventName.didUpdateCacheItems, EventName.didUpdateCacheItems);
        constants.put(EventName.didUpdateCall, EventName.didUpdateCall);
        constants.put(EventName.failAuthenticationRainbow, EventName.failAuthenticationRainbow);
        constants.put(EventName.requestAccessMicophone, EventName.requestAccessMicophone);
        constants.put(EventName.resyncBrowsingCache, EventName.resyncBrowsingCache);
        constants.put(EventName.failToStartRainbowService, EventName.failToStartRainbowService);
        return constants;
    }
}

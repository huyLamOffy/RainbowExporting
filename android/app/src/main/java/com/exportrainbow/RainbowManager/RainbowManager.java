package com.exportrainbow.RainbowManager;

import android.content.Context;
import android.util.Log;

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

    Context mContext;

    public RainbowManager(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;
    }

    @ReactMethod
    public void addEvent(String name, String location, int date) {
        Log.d(TAG, "addEvent: name - location - date" + name + location + date);
        WritableMap params = Arguments.createMap();
        params.putString("name", "didLogin");
        sendEvent((ReactContext) mContext, "DidLoginRainbow", params);
    }

    @ReactMethod
    public void getContactList(Callback callback) {
        Log.d(TAG, "getContactList: testCallback");
        callback.invoke("tha thu", "tha thu 2");
    }

    @ReactMethod
    public void getConversations(Callback callback) {

    }

    //RCT_EXTERN_METHOD(getContactList:(RCTResponseSenderBlock *)callback)
//    public void addEvent:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)date

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
        return constants;
    }
}

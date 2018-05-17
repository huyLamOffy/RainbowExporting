package com.exportrainbow.RainbowManager;

import android.graphics.Bitmap;
import android.util.Base64;

import com.ale.infra.contact.Contact;
import com.ale.infra.contact.IRainbowContact;
import com.ale.infra.list.ArrayItemList;
import com.ale.infra.proxy.conversation.IRainbowConversation;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;

import java.io.ByteArrayOutputStream;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

public class HelperMethods {
    static private String getBase64String(Bitmap bitmap)
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);

        byte[] imageBytes = baos.toByteArray();

        String base64String = Base64.encodeToString(imageBytes, Base64.NO_WRAP);

        return base64String;
    }

    static public WritableArray JSONFromContacts(ArrayItemList<IRainbowContact> contacts) {
        WritableArray array = Arguments.createArray();
        for (IRainbowContact contact: contacts.getCopyOfDataList()) {
            WritableMap map = Arguments.createMap();
            map.putString("rainbowID", contact.getContactId());
            map.putString("firstName", contact.getFirstName());
            map.putString("lastName", contact.getLastName());
            map.putString("peerJId", contact.getImJabberId());
            if (contact.getPhoto()!= null) {
                map.putString("photoData", getBase64String(contact.getPhoto()));
            }
            map.putString("emailAddress", contact.getFirstEmailAddress());
            if (contact.getFirstOfficePhoneNumber() != null) {
                map.putString("phoneNumber", contact.getFirstOfficePhoneNumber().getPhoneNumberValue());
            }
            map.putString("jobTitle", contact.getJobTitle());
            if (contact.getPresence() != null) { map.putString("presenceStatus", contact.getPresence().getPresence()); }
            array.pushMap(map);

        }
        return array;
    }

    static public WritableArray JSONFromConversations(ArrayItemList<IRainbowConversation> conversations) {
        WritableArray array = Arguments.createArray();
        for (IRainbowConversation conversation : conversations.getCopyOfDataList()) {
            WritableMap map = Arguments.createMap();
            map.putString("peerJId", conversation.getJid());
            if (conversation.getLastMessage() != null && conversation.getLastMessage().getMessageDate() != null)  {
                map.putString("lastMessage", conversation.getLastMessage().getMessageContent());
                map.putDouble("lastMessageTime", conversation.getLastMessage().getMessageDate().getTime());
            }
            map.putInt("unreadMessagesCount", conversation.getUnreadMsgNb());
            array.pushMap(map);

        }
        return array;
    }

}

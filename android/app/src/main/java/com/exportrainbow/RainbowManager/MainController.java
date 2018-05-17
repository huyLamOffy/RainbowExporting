package com.exportrainbow.RainbowManager;

import com.ale.infra.contact.Contact;
import com.ale.infra.contact.IRainbowContact;
import com.ale.infra.contact.RainbowPresence;
import com.ale.infra.list.ArrayItemList;
import com.ale.infra.list.IItemListChangeListener;
import com.ale.infra.proxy.conversation.IRainbowConversation;
import com.ale.rainbowsdk.RainbowSdk;

public class MainController implements Contact.ContactListener {
    private ArrayItemList<IRainbowContact> contactList = new ArrayItemList<>();
    private ArrayItemList<IRainbowConversation> m_conversations = new ArrayItemList<>();

    private IItemListChangeListener m_contactsListener = new IItemListChangeListener() {
        @Override
        public void dataChanged() {
            updateContacts();
            registerContactsOfConversationsList();
        }
    };

    private IItemListChangeListener m_conversationsListener = new IItemListChangeListener() {
        @Override
        public void dataChanged() {
            updateConversations();
        }
    };



    public ArrayItemList<IRainbowConversation> getConversations() {
        return m_conversations;
    }


    public ArrayItemList<IRainbowContact> getContactList() {
        return contactList;
    }

    public MainController() {
        updateConversations();
        updateContacts();
        registerChangeListener();
    }

    @Override
    protected void finalize() throws Throwable {
        super.finalize();
        unregisterChangeListener();
    }



    private void registerChangeListener() {
        RainbowSdk.instance().conversations().getAllConversations().registerChangeListener(m_conversationsListener);
        RainbowSdk.instance().contacts().getRainbowContacts().registerChangeListener(m_contactsListener);
        registerContactsOfConversationsList();
    }

    private void unregisterChangeListener() {
        RainbowSdk.instance().conversations().getAllConversations().unregisterChangeListener(m_conversationsListener);
        RainbowSdk.instance().contacts().getRainbowContacts().unregisterChangeListener(m_contactsListener);
        unregisterAllContacts();
    }

    private void updateConversations() {
        m_conversations.replaceAll(RainbowSdk.instance().conversations().getAllConversations().getCopyOfDataList());
    }

    private void updateContacts() {
        contactList.replaceAll( RainbowSdk.instance().contacts().getRainbowContacts().getCopyOfDataList());
    }

    @Override
    public void contactUpdated(Contact contact) {
        updateContacts();
        updateConversations();
    }

    @Override
    public void onPresenceChanged(Contact contact, RainbowPresence rainbowPresence) {

    }

    @Override
    public void onActionInProgress(boolean b) {

    }
    /**
     * Only listen to contacts of the list of conversations
     */
    private void registerContactsOfConversationsList() {
        for (IRainbowConversation conversation : RainbowSdk.instance().conversations().getAllConversations().getItems()) {
            if (conversation.getContact() != null) {
                conversation.getContact().registerChangeListener(this);
            }

        }
    }

    /**
     * Unregister all contacts
     */
    private void unregisterAllContacts() {
        for (IRainbowContact contact: RainbowSdk.instance().contacts().getRainbowContacts().getItems()) {
            contact.unregisterChangeListener(this);
        }
    }
}

/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  NativeEventEmitter,
  StyleSheet,
  NativeModules,
  TouchableHighlight,
  DeviceEventEmitter,
  Text,
  View
} from 'react-native';


//
const RainbowManager = NativeModules.RainbowManager;
RainbowManager.addEvent('Huy', 'Sai gon', 16)
// RainbowManager.getContactList((contacts) => {
//   console.log('contacts');
//   console.log(contacts);
// });
// const rainbowManagerEvt = new NativeEventEmitter(RainbowManager);
// var subscription = rainbowManagerEvt.addListener(
//       'DidLoginRainbow',
//       (progress) => {
//         console.log("DidLoginRainbow")
//         console.log(progress)
//         RainbowManager.getContactList((contacts) => {
//           console.log(contacts);
//           console.log('test');
//           RainbowManager.touchContact('test', contacts[0].rainbowID)
//         });
//         RainbowManager.getConversations((conversations) => {
//           RainbowManager.openConversation(conversations[1].rainbowID)
//           console.log(conversations);
//
//         });
//       }
//     );
// var subscription1 = rainbowManagerEvt.addListener(
//   'resyncBrowsingCache',
//   (progress) => {
//     console.log(progress);
//     console.log('resyncBrowsingCache');
//   }
// );
// var subscription2 = rainbowManagerEvt.addListener(
//   'didAddedCachedItems',
//   (newMessages) => {
//     console.log('didAddedCachedItems');
//     console.log(newMessages);
//     }
//   }
// );

// var subscription = NativeAppEventEmitter.addListener(
//     'EventReminder',
//     (reminder) => {
//         console.log('EVENT')
//         console.log('name: ' + reminder.name)
//         console.log('location: ' + reminder.location)
//         console.log('date: ' + reminder.date)
//     }
// );

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};

export default class App extends Component<Props> {
  componentWillMount() {
    console.log(RainbowManager);
    RainbowManager.loginWith('huylh@dgroup.co','SUGARdatingapp!23');
    DeviceEventEmitter.addListener(RainbowManager.didLoginRainbow, function(e: Event) {
    // handle event.
      console.log('DidLoginRainbow');
      console.log('wtf event');
      console.log(e);
    });
    DeviceEventEmitter.addListener(RainbowManager.didLogoutRainbow, function(e: Event) {
    // handle event.
      console.log('DidLogOutRainbow');
      console.log('wtf event');
      console.log(e);
    });
    console.log(DeviceEventEmitter);
  }
  render() {

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit App.js
        </Text>
        <Text style={styles.instructions}>
          {instructions}
        </Text>
        <TouchableHighlight
          underlayColor='transparent'
          style={{backgroundColor: 'red', marginTop: 20}}
          onPress = {() => {
            RainbowManager.logOut();
          }}
        >
          <Text>{`LogOut`}</Text>
        </TouchableHighlight>
        <TouchableHighlight
          underlayColor='transparent'
          style={{backgroundColor: 'red', marginTop: 20}}
          onPress = {() => {
            RainbowManager.getContactList((listContact)=>{
              console.log('listContact');
              console.log(listContact);
            });
          }}
        >
          <Text>{`getContactList`}</Text>
        </TouchableHighlight>
        <TouchableHighlight
          underlayColor='transparent'
          style={{backgroundColor: 'red', marginTop: 20}}
          onPress = {() => {
            RainbowManager.getConversations((listConversations)=>{
              console.log('Conversations');
              console.log(listConversations);
              RainbowManager.openConversation(listConversations[1].peerJId);
            });
          }}
        >
          <Text>{`getlistConversations`}</Text>
        </TouchableHighlight>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

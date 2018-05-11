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
  Text,
  View
} from 'react-native';

const RainbowManager = NativeModules.RainbowManager;
const rainbowManagerEvt = new NativeEventEmitter(RainbowManager);
var subscription = rainbowManagerEvt.addListener(
      'DidLoginRainbow',
      (progress) => {
        console.log("DidLoginRainbow")
        console.log(progress)
        RainbowManager.getContactList((contacts) => {
            console.log(contacts);
            RainbowManager.touchContact('test', contacts[0].rainbowID)
        });
      }
    );

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
  render() {
    RainbowManager.loginWith('huylh@dgroup.co', 'SUGARdatingapp!23');
    RainbowManager.addEvent('One', 'Two', 3);
    console.log(RainbowManager);
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
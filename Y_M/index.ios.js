/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  Navigator,
  InteractionManager,
  Platform,
  View
} from 'react-native';
import main from './jsApp/main/main';
import login from './jsApp/index/login';

const defaultRoute = {
  component: login
};

const styles = {
  title: {
    flex: 1, justifyContent: 'center', alignItems: 'center'
  },
  button: {
    flex: 1, width: 50, alignItems: 'center', justifyContent: 'center'
  },
  buttonText: {
    fontSize: 18, color: '#FFFFFF', fontWeight: '400'
  },
  navigationBar: {
    alignItems: 'center', backgroundColor: '#ff7e00',shadowColor: '#f07100',
    shadowOpacity: 0.8,
    shadowOffset:{width: 1, height: 0.3 }
  }
};

class Y_M extends Component {

  constructor(props, context) {
    super(props, context);
    this.state = {renderPlaceholderOnly: true};
  }

  componentDidMount() {
    InteractionManager.runAfterInteractions(() => {
      this.setState({renderPlaceholderOnly: false});
    });
  }

  _renderScene(route, navigator) {
    _navigator = navigator;
    let Component = route.component;
    return (
      <Component {...route.params} navigator={navigator} />
    );
  }

  _navigationBar(){
    var routeMapper = {
        LeftButton(route, navigator, index, navState) {
          if(index > 0) {
            return (
              <TouchableOpacity 
                onPress={() => navigator.pop()}
                style={styles.button}>
                <Text style={styles.buttonText}>Back</Text>
              </TouchableOpacity>
            );
          } else {
            return null;
          }
        },
        RightButton(route, navigator, index, navState) {
            return null
        },
        Title(route, navigator, index, navState) {
          return (
              <View style={styles.title}>
               <Text style={styles.buttonText}>{route.title ? route.title : 'Y_M'}</Text>
            </View>
          );
        }
      };
      return(
      <Navigator.NavigationBar
            style={styles.navigationBar}
            routeMapper={routeMapper}
          />
      );
    }

  render() {
    return (
        <Navigator
          initialRoute={defaultRoute}
          renderScene={this._renderScene}
          navigationBar={this._navigationBar()}
          sceneStyle={{paddingTop: (Platform.OS === 'android' ? 57 : 74)}}
           />
    );
  }
}


AppRegistry.registerComponent('Y_M', () => Y_M);

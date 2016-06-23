import React, { Component } from 'react';
import {
  AppRegistry,
  Text,
  TextInput,
  ScrollView,
  TouchableHighlight,
  Platform,
  BackAndroid,
  View
} from 'react-native';

import reqHttp from "../lib/reqHttp";

let pageUI,formUI;
if(Platform.OS === 'android'){
	pageUI = require("../lib/android/css/page.ui");
	formUI = require("../lib/android/css/form.ui");
} else if(Platform.OS === 'ios'){
	pageUI = require("../lib/ios/css/page.ui");
	formUI = require("../lib/ios/css/form.ui");
}


class signup extends Component {
	constructor(props) {
	    super(props);
	    this.state = {
	    	showTitleView:false,
	    	titleString:'',
	      	v_phoneNumber: ''
    	};
    	const navigator = this.props.navigator;
    	BackAndroid.addEventListener('hardwareBackPress', function() {
            if (navigator && navigator.getCurrentRoutes().length > 1) {
              navigator.pop();
              return true;
            }
            return false;
      	});

    	

    }

	_textInputChange(text){
		if(text.length === 11){ 
			this.setState({titleString:"手机号码正确！"});
			this.setState({showTitleView:true});
		} else {
			this.setState({showTitleView:false});
		}
		console.log(text);
	}

	_setTitleView(){
		if(!this.state.showTitleView){
			return null;
		}
		return (
			<View style={pageUI.titleView}>
				<Text>{this.state.titleString}</Text>
			</View>
		)
	}

	_signupUser(){
		
		reqHttp.setServiceParams({
    		"interfaceName":"controller/util/Random.json",
    		"flagSign":0,
    		"readableMap":{"phone":"15817161961"},
    		"actionCallback":(url,strJson)=>{
    			reqHttp.callHttpService({
                        'Url': url,
                        'Params': strJson,
                        'Success': (Params)=>{
                        	console.log(Params);
                        }
                    });
    		}
    	});
	}


	render() {
    return (
    	<ScrollView style={pageUI.container} keyboardShouldPersistTaps={true}>
    		<View style={[pageUI.centerTitle,pageUI.marginTB20]}>
    			<Text style={pageUI.titlefont}>signup</Text>
    		</View>
    		<View style={formUI.textInputView}>
	        	<TextInput style={formUI.textInput}
		        	placeholder="手机号码"
		        	maxLength={11}
		        	clearButtonMode="always"
		        	onChangeText={(text) => {
                      text = text.replace(/ /g, '_');
                      this.setState({v_phoneNumber:text});
                      this._textInputChange(text);
                    }}
		            value={this.state.v_phoneNumber}
		        	keyboardType={"phone-pad"}>
		        </TextInput>
	        </View>
	        <View style={formUI.textInputView}>
	        	<TextInput style={formUI.textInput}
		        	placeholder="邮箱"
		        	clearButtonMode="always">
		        </TextInput>
	        </View>
	        <View style={formUI.textInputView}>
	        	<TextInput style={formUI.textInput}
		        	placeholder="密码"
		        	secureTextEntry={true}
		        	clearButtonMode="always">
		        </TextInput>
	        </View>
	        {this._setTitleView()}
	        <TouchableHighlight underlayColor={'#f07000'} style={formUI.touchable} onPress={this._signupUser.bind(this)}>
			    <View><Text style={formUI.buttonTxt}>确定</Text></View>
			</TouchableHighlight>
      	</ScrollView>
    	)
	}
}

export default signup;

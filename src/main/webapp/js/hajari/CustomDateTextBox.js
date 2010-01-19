/*
	Copyright (c) 2004-2008, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/

function isDateInCurrentMonth(_date) {
	if (_date.getMonth() === new Date().getMonth() && _date <= new Date()) {
		return false;
	}
	return true;
}

if (!dojo._hasResource["js.hajari.CustomDateTextBox"]) {
	dojo._hasResource["js.hajari.CustomDateTextBox"]=true;
	dojo.provide("js.hajari.CustomDateTextBox");
	dojo.declare("js.hajari.CustomDateTextBox",
    		[dijit.form.DateTextBox],
    		{
    			_open: function(){
    				// summary:
    				//	opens the TimePicker, and sets the onValueSelected value

    				if(this.disabled || this.readOnly || !this.popupClass){return;}

    				var textBox = this;

    				if(!this._picker){
    					var PopupProto=dojo.getObject(this.popupClass, false);
    					this._picker = new PopupProto({
    						onValueSelected: function(value){
    							if(textBox._tabbingAway){
    								delete textBox._tabbingAway;
    							}else{
    								textBox.focus(); // focus the textbox before the popup closes to avoid reopening the popup
    							}
    							setTimeout(dojo.hitch(textBox, "_close"), 1); // allow focus time to take

    							// this will cause InlineEditBox and other handlers to do stuff so make sure it's last
    							dijit.form._DateTimeTextBox.superclass._setValueAttr.call(textBox, value, true);
    						},
    						lang: textBox.lang,
    						constraints: textBox.constraints,
    						isDisabledDate: function(/*Date*/ date){
    							// summary:
    							// 	disables dates outside of the min/max of the _DateTimeTextBox
    							var compare = dojo.date.compare;
    							var constraints = textBox.constraints;
    							var isDisabled = constraints && (constraints.min && (compare(constraints.min, date, "date") > 0) || (constraints.max && compare(constraints.max, date, "date") < 0));
    							
    							if(isDisabled){
    								return true;
    							}
    							
    							return isDateInCurrentMonth(date);
    						}
    					});
    					this._picker.attr('value', this.attr('value') || new Date());
    				}
    				if(!this._opened){
    					dijit.popup.open({
    						parent: this,
    						popup: this._picker,
    						around: this.domNode,
    						onCancel: dojo.hitch(this, this._close),
    						onClose: function(){ textBox._opened=false; }
    					});
    					this._opened=true;
    				}
    				
    				dojo.marginBox(this._picker.domNode,{ w:this.domNode.offsetWidth });
    			}
    		}
    	);

}

/**
 * 
 * @param eid
 * @param pm
 * @param im
 * @param isRequired
 * @param dp
 * @return
 */
function addDateDecoration(eid, pm, im, isRequired, dp) {
	Spring.addDecoration(new Spring.ElementDecoration({
		elementId : eid,
		widgetType : 'dijit.form.DateTextBox',
		widgetAttrs : {
			//constraints: {min: new Date().setDate(0), max: new Date().setDate(31), datePattern: dp},
			constraints: {datePattern: dp},
			promptMessage : pm,
			invalidMessage : im,
			required : isRequired,
			datePattern : dp
			//value : dojo.date.locale.parse(dojo.byId(eid).value, {selector : 'date', datePattern : dp, locale: djConfig.locale}),
		}
	}));
}

function deleteObjectByAdmin(id, name) {
	if (confirm("Are you sure for delete ["+ name +"] with id ["+ id +"] ?")) {
		window.location = "../admin/"+ name +"/delete/" + id;
	}
}

function archiveObjectByAdmin(id, name) {
	if (confirm("Are you sure for archive ["+ name +"] with id ["+ id +"] ?")) {
		window.location = "../admin/"+ name +"/archive/" + id;
	}
}

/** Dojo Key-Value-Widget */
function addFields(){
	var list = dojo.byId("wha_key_value_list");
	var num = eval(dojo.byId("counter").value);
	var keyTextField = createTextField("key", num);
	var valueTextField = createTextField("value", num);
	dojo.create("li",{
		id: "li"+num,
		innerHTML: "",
		className: "wha_key_value_li",
		style: {
			textDecoration: "none"
		}
	}, list, "first");
	valueTextField.placeAt("li"+num, "first");
	keyTextField.placeAt("li"+num, "first");
/*	TODO:: fix the delete button behaviour.
 * dojo.require('dijit.form.Button');
	var deleteButton = new dijit.form.Button({
		label: "X",
		style: { fontColor: 'red', fontWieght: 'bold' },
		onClick: function(){
			alert("li"+num);
			dojo.destroy("li"+num);
		}
	});
	deleteButton.placeAt("li"+num, "last");*/	
	
	num++;
	document.getElementById("counter").value = num;
}

function createTextField(prefix, num) {
	return new dijit.form.TextBox({
		name: prefix+num,
		value: "",
		id: prefix+num,
		placeHolder: "type in the " + prefix
	}, prefix+num);
}


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
			constraints: {min: new Date().setDate(0), max: new Date().setDate(31), datePattern: dp},
			promptMessage : pm,
			invalidMessage : im,
			required : isRequired,
			datePattern : dp,
			//value : dojo.date.locale.parse(dojo.byId(eid).value, {selector : 'date', datePattern : dp, locale: djConfig.locale}),
		}
	}));
}



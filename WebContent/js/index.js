Ext.setup({ 
	 icon : 'img/icon.png', 
	 tabletStartupScreen : 'img/tablet_startup.png', 
	 phoneStartupScreen : 'img/phone_startup.png', 
	 glossOnIcon : false, 

	 onReady : function() { 
		 var nestedList = new Ext.NestedList({ 
			 fullscreen : true, 
			 title : '我的订阅博客', 
			 displayField : 'text', 
			 dockedItems : [ topbar, bottombar ], 
			 store : store, 
			 getDetailCard : function(record, parentRecord) { 
				 return new Ext.ux.DescBox({ 
					 value : 'Loading...', 
					 scroll : { 
						 direction : 'both', 
						 eventTarget : 'parent'
					 } 
				 }); 
			 } 
		 }); 
		 }); 

	 } 
 });
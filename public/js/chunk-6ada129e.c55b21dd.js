(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-6ada129e"],{"1c5c":function(t,e,a){},"92fb":function(t,e,a){"use strict";a.r(e);var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{attrs:{id:"post-edit"}},[a("v-form",{model:{value:t.valid,callback:function(e){t.valid=e},expression:"valid"}},[a("v-text-field",{attrs:{rules:[function(t){return!!t||"megadása kötelező!"}],counter:100,label:"Cím",required:""},model:{value:t.post.attributes.title,callback:function(e){t.$set(t.post.attributes,"title",e)},expression:"post.attributes.title"}}),a("v-text-field",{attrs:{rules:[function(t){return!!t||"megadása kötelező!"}],counter:2e3,label:"Rövid leírás",hint:"megjelenik a főoldalon",required:""},model:{value:t.post.attributes.blurb,callback:function(e){t.$set(t.post.attributes,"blurb",e)},expression:"post.attributes.blurb"}}),a("editor-menu-bar",{attrs:{editor:t.editor},scopedSlots:t._u([{key:"default",fn:function(e){var i=e.commands,n=e.isActive;return a("div",{},[a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.bold()},attrs:{icon:""},on:{click:i.bold}},[a("v-icon",[t._v("format_bold")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.italic()},attrs:{icon:""},on:{click:i.italic}},[a("v-icon",[t._v("format_italic")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.strike()},attrs:{icon:""},on:{click:i.strike}},[a("v-icon",[t._v("strikethrough_s")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.underline()},attrs:{icon:""},on:{click:i.underline}},[a("v-icon",[t._v("format_underline")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.heading({level:1})},attrs:{icon:""},on:{click:function(t){i.heading({level:1})}}},[t._v("\n          H1\n        ")]),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.heading({level:2})},attrs:{icon:""},on:{click:function(t){i.heading({level:2})}}},[t._v("\n          H2\n        ")]),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.heading({level:3})},attrs:{icon:""},on:{click:function(t){i.heading({level:3})}}},[t._v("\n          H3\n        ")]),a("v-btn",{staticClass:"menubar__button",attrs:{icon:""},on:{click:i.horizontal_rule}},[a("v-icon",[t._v("remove")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.bullet_list()},attrs:{icon:""},on:{click:i.bullet_list}},[a("v-icon",[t._v("format_list_bulleted")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":n.ordered_list()},attrs:{icon:""},on:{click:i.ordered_list}},[a("v-icon",[t._v("format_list_numbered")])],1),a("v-btn",{staticClass:"menubar__button",attrs:{icon:""},on:{click:i.undo}},[a("v-icon",[t._v("undo")])],1),a("v-btn",{staticClass:"menubar__button",attrs:{icon:""},on:{click:i.redo}},[a("v-icon",[t._v("redo")])],1),a("v-dialog",{attrs:{width:"800"},model:{value:t.dialog,callback:function(e){t.dialog=e},expression:"dialog"}},[a("v-btn",{attrs:{slot:"activator",icon:""},slot:"activator"},[a("v-icon",[t._v("image")])],1),a("v-card",[a("v-card-title",[a("h2",[t._v("\n                Kép beillesztés\n              ")])]),a("v-form",[a("v-container",[a("v-layout",{attrs:{row:"",wrap:""}},[a("v-flex",{attrs:{xs6:""}},[a("v-text-field",{attrs:{label:"Kép leirás"},model:{value:t.image.title,callback:function(e){t.$set(t.image,"title",e)},expression:"image.title"}})],1),a("v-flex",{attrs:{xs6:""}},[a("v-text-field",{attrs:{label:"Kép alt szöveg"},model:{value:t.image.alt,callback:function(e){t.$set(t.image,"alt",e)},expression:"image.alt"}})],1),a("v-flex",{attrs:{xs4:""}},[a("v-checkbox",{attrs:{color:"red",label:"Fix szélesség"},model:{value:t.image.fix_width,callback:function(e){t.$set(t.image,"fix_width",e)},expression:"image.fix_width"}})],1),a("v-flex",{attrs:{xs8:""}},[a("v-slider",{attrs:{color:"red",max:"800","inverse-label":"",label:t.image.width+"px"},model:{value:t.image.width,callback:function(e){t.$set(t.image,"width",e)},expression:"image.width"}})],1),a("v-flex",{attrs:{xs4:""}},[a("v-checkbox",{attrs:{color:"red",label:"Fix magasság"},model:{value:t.image.fix_height,callback:function(e){t.$set(t.image,"fix_height",e)},expression:"image.fix_height"}})],1),a("v-flex",{attrs:{xs8:""}},[a("v-slider",{attrs:{color:"red","inverse-label":"",max:"400",label:t.image.height+"px"},model:{value:t.image.height,callback:function(e){t.$set(t.image,"height",e)},expression:"image.height"}})],1),a("v-flex",{attrs:{xs12:"","text-sx-center":""}},[a("v-radio-group",{attrs:{row:""},model:{value:t.image.align,callback:function(e){t.$set(t.image,"align",e)},expression:"image.align"}},[a("v-radio",{attrs:{color:"red",label:"Igazítás balra",value:"content-image-left"}}),a("v-radio",{attrs:{color:"red",label:"Igazítás középre",value:"content-image-center"}}),a("v-radio",{attrs:{color:"red",label:"Igazítás jobbra",value:"content-image-right"}})],1)],1),a("v-flex",{staticClass:"text-xs-center text-sm-center text-md-center text-lg-center",attrs:{xs12:""}},[t.image.url?a("img",{attrs:{src:t.image.url,height:"250"}}):t._e(),a("v-text-field",{attrs:{label:"Kép kiválasztása","prepend-icon":"attach_file"},on:{click:t.pickFile},model:{value:t.image.name,callback:function(e){t.$set(t.image,"name",e)},expression:"image.name"}}),a("input",{ref:"image",staticStyle:{display:"none"},attrs:{type:"file",accept:"image/*"},on:{change:t.onFilePicked}})],1)],1)],1)],1),a("v-card-actions",[a("v-spacer"),a("v-btn",{on:{click:function(e){t.cancelInsertImage()}}},[t._v("Mégsem\n              ")]),a("v-btn",{attrs:{color:"success"},on:{click:function(e){t.insertImage(i.image_ext)}}},[t._v("\n                Beillesztés\n              ")])],1)],1)],1)],1)}}])}),a("editor-content",{attrs:{id:"my-editor",editor:t.editor}}),a("div",{staticClass:"meta"},[a("p",[t._v("Létrehozva: "),a("span",[t._v(t._s(t.createdAt))])]),a("p",[t._v("Utolsó frissítés: "),a("span",[t._v(t._s(t.updatedAt))])])]),a("v-btn",{attrs:{to:"/admin/posts"}},[t._v("Mégsem")]),a("v-btn",{attrs:{color:"success",disabled:!t.valid},on:{click:function(e){t.sendToServer()}}},[t._v("Mentés\n    ")])],1)],1)},n=[],o=a("768b"),s=(a("7f7f"),a("cadf"),a("551c"),a("097d"),a("bc3a")),l=a.n(s),c=a("cd42"),r=a("f23d"),d=a("37ff"),u={name:"Post",components:{EditorContent:c["b"],EditorMenuBar:c["c"]},data:function(){var t=this;return{valid:!0,active:!0,image:{align:"content-image-left",url:"",name:"",file:"",width:400,height:0,alt:"",title:"",fix_width:!0,fix_height:!1},dialog:!1,html:"",editor:new c["a"]({extensions:[new r["a"],new r["f"],new r["i"],new r["l"],new r["c"]({levels:[1,2,3]}),new r["b"],new r["h"],new r["g"],new r["j"],new r["k"],new r["e"],new r["d"],new d["a"]],onUpdate:function(e){var a=e.getHTML;t.html=a(),t.post.attributes.content=a()}}),post:{id:0,attributes:{title:"",blurb:"",content:"",thumbnail_url:""}}}},methods:{insertImage:function(t){var e=this,a="http://206.189.55.142/api/",i=new FormData;i.append("image",this.image.file),l.a.post("".concat(a,"/embedded_image"),i,{headers:{Authorization:"Bearer ".concat(window.localStorage.getItem("user_token")),Accept:"application/json","Content-Type":"multipart/form-data"}}).then(function(a){console.log("SUCCESS!!"),console.log(a.data.url);var i={src:a.data.url,title:e.image.title,alt:e.image.alt,class:e.image.align};e.image.fix_width&&(i.width="".concat(e.image.width)),e.image.fix_height&&(i.height="".concat(e.image.height)),console.log(i),t(i),e.dialog=!1,e.image={align:"content-image-left",url:"",name:"",file:"",width:400,height:0,alt:"",title:"",fix_width:!0,fix_height:!1}}).catch(function(t){console.log("FAILURE!!"),console.log(t)})},cancelInsertImage:function(){this.dialog=!1},pickFile:function(){this.$refs.image.click()},onFilePicked:function(t){var e=this;console.log("file picked");var a=t.target.files;if(void 0!==a[0]){if(this.image.name=a[0].name,this.image.name.lastIndexOf(".")<=0)return void(this.image.name="");var i=new FileReader;i.readAsDataURL(a[0]),i.addEventListener("load",function(){e.image.url=i.result;var t=Object(o["a"])(a,1);e.image.file=t[0]})}else this.image.name="",this.image.file="",this.image.url=""},sendToServer:function(){var t=this,e="http://206.189.55.142/api/",a={type:"posts",attributes:{title:this.post.attributes.title,blurb:this.post.attributes.blurb,content:this.post.attributes.content,thumbnail_url:this.post.attributes.thumbnail_url}};console.log(a),0===this.post.id?l.a.post("".concat(e,"posts"),{data:a},{headers:{Authorization:"Bearer ".concat(window.localStorage.getItem("user_token")),Accept:"application/vnd.api+json","Content-Type":"application/vnd.api+json"}}).then(function(){t.$router.push("/admin/posts")}).catch(function(t){console.log(t.data)}):l.a.patch("".concat(e,"posts/").concat(this.post.id),{data:a},{headers:{Authorization:"Bearer ".concat(window.localStorage.getItem("user_token")),Accept:"application/vnd.api+json","Content-Type":"application/vnd.api+json"}}).then(function(){t.$router.push("/admin/posts")}).catch(function(t){console.log(t.data)})}},computed:{createdAt:function(){return new Date(this.post.attributes.created_at).toLocaleString("hu-HU")},updatedAt:function(){return new Date(this.post.attributes.updated_at).toLocaleString("hu-HU")}},mounted:function(){var t=this;"admin-post-new"===this.$route.name||l.a.get("http://206.189.55.142/api/posts/".concat(this.$route.params.id)).then(function(e){t.post=e.data.data,t.editor.setContent(e.data.data.attributes.content)})},beforeDestroy:function(){this.editor.destroy()}},v=u,m=(a("f572"),a("2877")),g=a("6544"),b=a.n(g),h=a("8336"),f=a("b0af"),p=a("99d9"),_=a("12b2"),x=a("ac7c"),k=a("a523"),w=a("169a"),C=a("0e8f"),z=a("4bd4"),V=a("132d"),$=a("a722"),I=a("67b6"),A=a("43a6"),S=a("ba0d"),y=a("9910"),F=a("2677"),j=Object(m["a"])(v,i,n,!1,null,"2eff490b",null);j.options.__file="Post.vue";e["default"]=j.exports;b()(j,{VBtn:h["a"],VCard:f["a"],VCardActions:p["a"],VCardTitle:_["a"],VCheckbox:x["a"],VContainer:k["a"],VDialog:w["a"],VFlex:C["a"],VForm:z["a"],VIcon:V["a"],VLayout:$["a"],VRadio:I["a"],VRadioGroup:A["a"],VSlider:S["a"],VSpacer:y["a"],VTextField:F["a"]})},f572:function(t,e,a){"use strict";var i=a("1c5c"),n=a.n(i);n.a}}]);
//# sourceMappingURL=chunk-6ada129e.c55b21dd.js.map
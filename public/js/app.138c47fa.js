(function(t){function e(e){for(var n,l,s=e[0],r=e[1],c=e[2],u=0,v=[];u<s.length;u++)l=s[u],o[l]&&v.push(o[l][0]),o[l]=0;for(n in r)Object.prototype.hasOwnProperty.call(r,n)&&(t[n]=r[n]);d&&d(e);while(v.length)v.shift()();return i.push.apply(i,c||[]),a()}function a(){for(var t,e=0;e<i.length;e++){for(var a=i[e],n=!0,l=1;l<a.length;l++){var r=a[l];0!==o[r]&&(n=!1)}n&&(i.splice(e--,1),t=s(s.s=a[0]))}return t}var n={},o={app:0},i=[];function l(t){return s.p+"js/"+({about:"about"}[t]||t)+"."+{about:"ab57d3e5"}[t]+".js"}function s(e){if(n[e])return n[e].exports;var a=n[e]={i:e,l:!1,exports:{}};return t[e].call(a.exports,a,a.exports,s),a.l=!0,a.exports}s.e=function(t){var e=[],a=o[t];if(0!==a)if(a)e.push(a[2]);else{var n=new Promise(function(e,n){a=o[t]=[e,n]});e.push(a[2]=n);var i,r=document.createElement("script");r.charset="utf-8",r.timeout=120,s.nc&&r.setAttribute("nonce",s.nc),r.src=l(t),i=function(e){r.onerror=r.onload=null,clearTimeout(c);var a=o[t];if(0!==a){if(a){var n=e&&("load"===e.type?"missing":e.type),i=e&&e.target&&e.target.src,l=new Error("Loading chunk "+t+" failed.\n("+n+": "+i+")");l.type=n,l.request=i,a[1](l)}o[t]=void 0}};var c=setTimeout(function(){i({type:"timeout",target:r})},12e4);r.onerror=r.onload=i,document.head.appendChild(r)}return Promise.all(e)},s.m=t,s.c=n,s.d=function(t,e,a){s.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:a})},s.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},s.t=function(t,e){if(1&e&&(t=s(t)),8&e)return t;if(4&e&&"object"===typeof t&&t&&t.__esModule)return t;var a=Object.create(null);if(s.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var n in t)s.d(a,n,function(e){return t[e]}.bind(null,n));return a},s.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return s.d(e,"a",e),e},s.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},s.p="/",s.oe=function(t){throw console.error(t),t};var r=window["webpackJsonp"]=window["webpackJsonp"]||[],c=r.push.bind(r);r.push=e,r=r.slice();for(var u=0;u<r.length;u++)e(r[u]);var d=c;i.push([0,"chunk-vendors"]),a()})({0:function(t,e,a){t.exports=a("56d7")},"070c":function(t,e,a){},1001:function(t,e,a){},"1dbc":function(t,e,a){},"4b9f":function(t,e,a){"use strict";var n=a("1001"),o=a.n(n);o.a},"56d7":function(t,e,a){"use strict";a.r(e);a("cadf"),a("551c"),a("097d");var n=a("2b0e"),o=a("bb71");a("da64");n["a"].use(o["a"],{iconfont:"md"});var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-app",[a("v-content",{staticClass:"wrapper"},[a("Navigation"),a("router-view")],1),a("Footer")],1)},l=[],s=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-footer",{attrs:{height:"auto",dark:""}},[a("ul",[a("li",[t._v("Cím: H-1056 Budapest Váci utca 62-64")]),a("li",[t._v("Telefon: +36-1-266-91-30")]),a("li",[t._v("E-mail: info@johannitak.hu")]),a("li",[t._v("Facebook: https://www.facebook.com/johannitak.hu/")]),a("li",[t._v(" ")]),a("li",[t._v("Adószám: 19650768-1-41")]),a("li",[t._v("Főszámlaszáma: OTP BANK Nyrt, 11705008-20410322")]),a("li",[t._v(" ")]),a("li",[t._v("© 2018 - Minden jog fenntartva!")])])])},r=[],c={name:"Footer"},u=c,d=(a("86bc"),a("2877")),v=a("6544"),m=a.n(v),f=a("553a"),p=Object(d["a"])(u,s,r,!1,null,"8b75c426",null);p.options.__file="Footer.vue";var b=p.exports;m()(p,{VFooter:f["a"]});var g=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-container",{attrs:{id:"header"}},[a("v-layout",{attrs:{row:"","justify-end":""}},[a("Profile")],1),a("v-layout",{attrs:{row:"","align-center":""}},[a("v-flex",{attrs:{shrink:""}},[a("router-link",{attrs:{to:"/"}},[a("Logo")],1)],1),a("v-flex",{staticClass:"menu",attrs:{grow:""}},[t.isAdminRoute?a("v-toolbar",{attrs:{flat:"",color:"white"}},[a("v-spacer"),a("v-toolbar-items",[a("v-btn",{attrs:{to:"/admin/dashboard",flat:""}},[t._v("Dashboard")]),a("v-btn",{attrs:{to:"/admin/pages",flat:""}},[t._v("Oldalak")]),a("v-btn",{attrs:{to:"/admin/posts",flat:""}},[t._v("Hirek")]),a("v-btn",{attrs:{to:"/admin/users",flat:""}},[t._v("Felhasznalok")]),a("v-btn",{attrs:{to:"/admin/course_categories",flat:""}},[t._v("Esemény kategóriák")]),a("v-btn",{attrs:{to:"/admin/course_events",flat:""}},[t._v("Tanfolyam események")]),a("v-btn",{attrs:{to:"/admin/courses",flat:""}},[t._v("Tanfolyamok")])],1)],1):a("v-toolbar",{attrs:{id:"public-menu",flat:"",color:"white"}},[a("v-spacer"),a("v-toolbar-items",[a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("A segítő szolgálat")]),a("SubMenu",{attrs:{items:t.menu.rolunk}})],1),a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Tevékenységeink")]),a("SubMenu",{attrs:{items:t.menu.tevekenyseg}})],1),a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Számítunk rád!")]),a("SubMenu",{attrs:{items:t.menu.jelentkezes}})],1),a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Támogatás")]),a("SubMenu",{attrs:{items:t.menu.tamogatas}})],1),a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Johannita Tábor")]),a("SubMenu",{attrs:{items:t.menu.tabor}})],1),a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Kapcsolat")]),a("SubMenu",{attrs:{items:t.menu.kapcsolat}})],1)],1)],1)],1)],1)],1)},h=[],_=(a("f559"),function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-layout",{attrs:{"align-center":""}},[n("v-flex",[n("img",{attrs:{src:a("cf05"),alt:"johannita logo"}})]),n("v-flex",[n("div",{staticClass:"logo-text"},[n("div",[t._v("Johannita")]),n("div",[t._v("Segítő")]),n("div",[t._v("Szolgálat")])])])],1)}),k=[],x={name:"Logo"},w=x,z=(a("ae73"),a("0e8f")),y=a("a722"),j=Object(d["a"])(w,_,k,!1,null,"1aab42be",null);j.options.__file="Logo.vue";var V=j.exports;m()(j,{VFlex:z["a"],VLayout:y["a"]});var C=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",t._l(t.items,function(e,n){return a("v-list-tile",{key:n,staticClass:"submenu-item",attrs:{to:e.to,"active-class":"active-item"}},[a("v-list-tile-title",[t._v(t._s(e.title))])],1)}),1)},T=[],S={name:"SubMenu",props:["items"]},A=S,O=(a("ffa2"),a("ba95")),E=a("5d23"),L=Object(d["a"])(A,C,T,!1,null,"44c081b4",null);L.options.__file="SubMenu.vue";var $=L.exports;m()(L,{VListTile:O["a"],VListTileTitle:E["b"]});var F=function(){var t=this,e=t.$createElement,a=t._self._c||e;return t.getToken()?a("div",{staticClass:"user-profile-logged-in"},[a("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[a("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("\n      "+t._s(t.getEmail())+"\n    ")]),a("v-list",[t._l(t.items,function(e,n){return a("v-list-tile",{key:n,attrs:{to:e.to}},[a("v-list-tile-title",[t._v(t._s(e.title))])],1)}),a("v-divider"),a("v-list-tile",{on:{click:t.logout}},[a("v-list-tile-title",[t._v("Logout")])],1)],2)],1)],1):a("div",{staticClass:"user-profile"},[a("router-link",{attrs:{to:"/bejelentkezes"}},[t._v("Bejelentkezés")]),t._v("\n  /\n  "),a("router-link",{attrs:{to:"/regisztracio"}},[t._v("Regisztráció")])],1)},I=[],M={name:"Profile",data:function(){return{items:[{title:"Profil",to:"#"},{title:"Admin",to:"/admin"}]}},methods:{getToken:function(){return window.localStorage.getItem("user_token")},getEmail:function(){return window.localStorage.getItem("user_email")},logout:function(){window.localStorage.removeItem("user_token"),window.localStorage.removeItem("user_email"),window.location.href="/",console.log("logout")}}},P=M,R=(a("e8a8"),a("8336")),D=a("ce7e"),H=a("8860"),B=a("e449"),J=Object(d["a"])(P,F,I,!1,null,"f398a694",null);J.options.__file="Profile.vue";var K=J.exports;m()(J,{VBtn:R["a"],VDivider:D["a"],VList:H["a"],VListTile:O["a"],VListTileTitle:E["b"],VMenu:B["a"]});var U={name:"Navigation",components:{Logo:V,SubMenu:$,Profile:K},data:function(){return{menu:{rolunk:[{title:"Elnöki köszöntő",to:"/oldal/elnoki_koszonto"},{title:"Rólunk",to:"/oldal/rolunk"},{title:"Helyi szervezetek",to:"/oldal/helyi_szervezetek"},{title:"Közhasznúságú jelentések",to:"/oldal/kozhasznu_jelentesek"},{title:"Aktuális projektek",to:"/oldal/projektek"},{title:"Johanniter International",to:"/oldal/johanniter"}],tevekenyseg:[{title:"Elsősegélynújtás",to:"/oldal/elnoki_koszonto"},{title:"Eszközkölcsönzés",to:"/oldal/eszkozkolcsonzes"},{title:"Hedrehelzi idősek klubja",to:"/oldal/helyi_szervezetek"},{title:"Humanitárius segélyezés",to:"/oldal/kozhasznu_jelentesek"},{title:"Ifjúsági munka",to:"/oldal/ifjusagi_munka"},{title:"Katasztrófavédelem",to:"/oldal/katasztrofavedelem"},{title:"Mentőszolgálat",to:"/oldal/mentoszolgalat"}],jelentkezes:[{title:"Jelentkezés Képzésre",to:"/oldal/jelentkezes_kepzes"},{title:"Jelentkezes Onkentes Lehetosegekre",to:"/oldal/jelentkezes_onkentes"}],tamogatas:[{title:"Báróti háztűz",to:"/oldal/elnoki_koszonto"},{title:"Elsősegély program",to:"/oldal/rolunk1"},{title:"Guti Óvoda",to:"/oldal/helyi_szervezetek"},{title:"Háromkút Iskolatűz",to:"/oldal/kozhasznu_jelentesek"},{title:"Kárpátalja",to:"/oldal/karpatalja"},{title:"Táti gázrobbanás",to:"/oldal/gazrobbanas_tat"},{title:"Terényi tűz",to:"/oldal/terenyi_tuz"},{title:"Zólyomi család",to:"/oldal/zolyomi_csalad"}],tabor:[{title:"Tábor információk",to:"/oldal/tabor_informaciok"},{title:"Jelentkezés a táborba",to:"/oldal/tabor_jelentkezes"},{title:"A tábor története",to:"/oldal/tabor_tortenet"}],kapcsolat:[{title:"Hírlevel",to:"/oldal/foo_bar"}]}}},computed:{isAdminRoute:function(){return this.$route.path.startsWith("/admin")}}},q=U,N=(a("4b9f"),a("a523")),G=a("9910"),W=a("71d9"),Z=a("2a7f"),Q=Object(d["a"])(q,g,h,!1,null,"55470cba",null);Q.options.__file="Navigation.vue";var X=Q.exports;m()(Q,{VBtn:R["a"],VContainer:N["a"],VFlex:z["a"],VLayout:y["a"],VMenu:B["a"],VSpacer:G["a"],VToolbar:W["a"],VToolbarItems:Z["a"]});var Y={name:"App",components:{Footer:b,Navigation:X},data:function(){return{}}},tt=Y,et=(a("5c0b"),a("7496")),at=a("549c"),nt=Object(d["a"])(tt,i,l,!1,null,null,null);nt.options.__file="App.vue";var ot=nt.exports;m()(nt,{VApp:et["a"],VContent:at["a"]});var it=a("8c4f"),lt=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[t.loading?a("div",{staticClass:"loading"},[t._v("\n    Loading...\n  ")]):t._e(),t.error?a("div",{staticClass:"error"},[t._v("\n    "+t._s(t.error)+"\n  ")]):t._e(),t.posts?a("div",{staticClass:"content"},[a("v-timeline",t._l(t.posts,function(e){return a("v-timeline-item",{key:e.id,staticClass:"mb-3",attrs:{color:"red",right:"",small:""}},[a("span",{class:"font-weight-bold red--text",attrs:{slot:"opposite"},domProps:{textContent:t._s(new Date(e.attributes.created_at).toLocaleDateString("hu-HU"))},slot:"opposite"}),a("div",{},[a("h2",{class:"headline font-weight-light mb-3 red--text"},[t._v(t._s(e.attributes.title))]),a("div",{domProps:{innerHTML:t._s(e.attributes.blurb)}})])])}),1)],1):t._e()])},st=[],rt=a("bc3a"),ct=a.n(rt),ut={name:"Home",data:function(){return{posts:[]}},created:function(){this.fetchData()},methods:{fetchData:function(){var t=this;this.error=null,this.posts=null,this.loading=!0;var e="http://206.189.55.142/api/",a="".concat(e,"posts");ct.a.get(a,{headers:{Accept:"application/json","Content-Type":"application/vnd.api+json"}}).then(function(e){t.loading=!1,t.posts=e.data.data.reverse()}).catch(function(e){t.loading=!1,t.error=e.response.data.error})}}},dt=ut,vt=a("8414"),mt=a("1e06"),ft=Object(d["a"])(dt,lt,st,!1,null,"6c951dd7",null);ft.options.__file="Home.vue";var pt=ft.exports;m()(ft,{VTimeline:vt["a"],VTimelineItem:mt["a"]});var bt=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-container",[a("v-layout",{attrs:{"align-center":"","justify-center":"",column:"","fill-height":""}},[a("v-form",{ref:"form",attrs:{id:"login-form"},model:{value:t.valid,callback:function(e){t.valid=e},expression:"valid"}},[a("v-flex",{attrs:{xs12:""}},[a("v-text-field",{attrs:{color:"red",rules:t.emailRules,name:"email","validate-on-blur":"",label:"E-mail",required:""},model:{value:t.email,callback:function(e){t.email=e},expression:"email"}})],1),a("v-flex",{attrs:{xs12:""}},[a("v-text-field",{attrs:{color:"red","append-icon":t.show1?"visibility_off":"visibility",rules:t.passwordRules,type:t.show1?"text":"password",name:"password",label:"Jelszó",counter:""},on:{"click:append":function(e){t.show1=!t.show1}},model:{value:t.password,callback:function(e){t.password=e},expression:"password"}})],1),a("v-flex",{attrs:{xs12:"","text-xs-center":""}},[a("v-btn",{attrs:{"align-self-center":"",disabled:!t.valid,color:"success"},on:{click:t.login}},[t._v("\n          Bejelentkezés\n        ")])],1)],1)],1)],1)},gt=[],ht={name:"Login",data:function(){return{valid:!0,show1:!1,password:"",passwordRules:[function(t){return!!t||"Jelszó megadása kötelező!"},function(t){return t&&t.length>=8||"A jelszó minimum 8 karakter"}],email:"",emailRules:[function(t){return!!t||"E-mail megadása kötelező"},function(t){return/.+@.+/.test(t)||"Hibás email formátum"}]}},methods:{login:function(){var t=this,e="http://206.189.55.142/api/",a="".concat(e,"auth?user=").concat(this.email,"&password=").concat(this.password);ct.a.post(a,null,{headers:{Accept:"application/json","Content-Type":"multipart/form-data"}}).then(function(e){var a=e.data.token;console.log(a),a&&(window.localStorage.setItem("user_email",t.email),window.localStorage.setItem("user_token",a),window.location.href="/")}).catch()}}},_t=ht,kt=(a("a040"),a("4bd4")),xt=a("2677"),wt=Object(d["a"])(_t,bt,gt,!1,null,"049b1971",null);wt.options.__file="Login.vue";var zt=wt.exports;m()(wt,{VBtn:R["a"],VContainer:N["a"],VFlex:z["a"],VForm:kt["a"],VLayout:y["a"],VTextField:xt["a"]});var yt=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[t.loading?a("div",{staticClass:"loading"},[t._v("\n    Loading...\n  ")]):t._e(),t.error?a("div",{staticClass:"error"},[t._v("\n    "+t._s(t.error)+"\n  ")]):t._e(),t.page?a("div",{staticClass:"content"},[t._v("\n    "+t._s(t.page.attributes.content)+"\n  ")]):t._e()])},jt=[],Vt={name:"Page",data:function(){return{loading:!1,error:null,page:null}},created:function(){this.fetchData()},watch:{$route:"fetchData"},methods:{fetchData:function(){var t=this;this.error=null,this.page=null,this.loading=!0;var e=this.$route.params.id,a="http://206.189.55.142/api/",n="".concat(a,"pages/").concat(e);ct.a.get(n,{headers:{Accept:"application/json","Content-Type":"application/vnd.api+json"}}).then(function(e){t.loading=!1,t.page=e.data.data}).catch(function(e){t.loading=!1,t.error=e.response.data.error})}}},Ct=Vt,Tt=Object(d["a"])(Ct,yt,jt,!1,null,"4ec1a5c4",null);Tt.options.__file="Page.vue";var St=Tt.exports,At=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("v-toolbar",{attrs:{flat:"",color:"white"}},[a("v-spacer"),a("v-btn",{attrs:{color:"success"}},[t._v("új hír")])],1),a("v-data-table",{attrs:{headers:t.headers,items:t.posts},scopedSlots:t._u([{key:"items",fn:function(e){return[a("td",[t._v(t._s(e.item.id))]),a("td",[t._v(t._s(new Date(e.item.attributes.created_at).toLocaleString("hu-HU")))]),a("td",[t._v(t._s(e.item.attributes.title))]),a("td",[a("v-btn",{attrs:{icon:"",to:"/admin/posts/"+e.item.id+"/edit"}},[a("v-icon",[t._v("edit")])],1),a("v-btn",{attrs:{icon:"",to:"/admin/posts/1/edit"}},[a("v-icon",[t._v("delete")])],1)],1)]}}])})],1)},Ot=[],Et={name:"Posts",data:function(){return{headers:[{text:"ID",align:"left",value:"id"},{text:"Létrehozva",align:"left",value:"attributes.created_at"},{text:"Cim",align:"left",value:"attributes.title"},{text:"Opciók",sortable:!1}],posts:[]}},mounted:function(){var t=this;ct.a.get("http://206.189.55.142/api/posts").then(function(e){t.posts=e.data.data})}},Lt=Et,$t=a("8fea"),Ft=a("132d"),It=Object(d["a"])(Lt,At,Ot,!1,null,"2b3e7b64",null);It.options.__file="Posts.vue";var Mt=It.exports;m()(It,{VBtn:R["a"],VDataTable:$t["a"],VIcon:Ft["a"],VSpacer:G["a"],VToolbar:W["a"]});var Pt=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{attrs:{id:"post-edit"}},[a("v-form",[a("v-text-field",{attrs:{counter:100,label:"Cím",required:""},model:{value:t.post.attributes.title,callback:function(e){t.$set(t.post.attributes,"title",e)},expression:"post.attributes.title"}}),a("v-text-field",{attrs:{counter:2e3,label:"Rövid leírás",hint:"megjelenik a főoldalon",required:""},model:{value:t.post.attributes.blurb,callback:function(e){t.$set(t.post.attributes,"blurb",e)},expression:"post.attributes.blurb"}}),a("editor-menu-bar",{attrs:{editor:t.editor},scopedSlots:t._u([{key:"default",fn:function(e){var n=e.commands,o=e.isActive;return a("div",{},[a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.bold()},attrs:{icon:""},on:{click:n.bold}},[a("v-icon",[t._v("format_bold")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.italic()},attrs:{icon:""},on:{click:n.italic}},[a("v-icon",[t._v("format_italic")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.strike()},attrs:{icon:""},on:{click:n.strike}},[a("v-icon",[t._v("strikethrough_s")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.underline()},attrs:{icon:""},on:{click:n.underline}},[a("v-icon",[t._v("format_underline")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.heading({level:1})},attrs:{icon:""},on:{click:function(t){n.heading({level:1})}}},[t._v("\n          H1\n        ")]),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.heading({level:2})},attrs:{icon:""},on:{click:function(t){n.heading({level:2})}}},[t._v("\n          H2\n        ")]),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.heading({level:3})},attrs:{icon:""},on:{click:function(t){n.heading({level:3})}}},[t._v("\n          H3\n        ")]),a("v-btn",{staticClass:"menubar__button",attrs:{icon:""},on:{click:n.horizontal_rule}},[a("v-icon",[t._v("remove")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.bullet_list()},attrs:{icon:""},on:{click:n.bullet_list}},[a("v-icon",[t._v("format_list_bulleted")])],1),a("v-btn",{staticClass:"menubar__button",class:{"is-active":o.ordered_list()},attrs:{icon:""},on:{click:n.ordered_list}},[a("v-icon",[t._v("format_list_numbered")])],1),a("v-btn",{staticClass:"menubar__button",attrs:{icon:""},on:{click:n.undo}},[a("v-icon",[t._v("undo")])],1),a("v-btn",{staticClass:"menubar__button",attrs:{icon:""},on:{click:n.redo}},[a("v-icon",[t._v("redo")])],1),a("v-dialog",{attrs:{width:"800"},model:{value:t.dialog,callback:function(e){t.dialog=e},expression:"dialog"}},[a("v-btn",{attrs:{slot:"activator",icon:""},slot:"activator"},[a("v-icon",[t._v("image")])],1),a("v-card",[a("v-card-title",[a("h2",[t._v("\n                Kép beillesztés\n              ")])]),a("v-form",[a("v-container",[a("v-layout",{attrs:{row:"",wrap:""}},[a("v-flex",{attrs:{xs6:""}},[a("v-text-field",{attrs:{label:"Kép leirás"},model:{value:t.image.title,callback:function(e){t.$set(t.image,"title",e)},expression:"image.title"}})],1),a("v-flex",{attrs:{xs6:""}},[a("v-text-field",{attrs:{label:"Kép alt szöveg"},model:{value:t.image.alt,callback:function(e){t.$set(t.image,"alt",e)},expression:"image.alt"}})],1),a("v-flex",{attrs:{xs4:""}},[a("v-checkbox",{attrs:{color:"red",label:"Fix szélesség"},model:{value:t.image.fix_width,callback:function(e){t.$set(t.image,"fix_width",e)},expression:"image.fix_width"}})],1),a("v-flex",{attrs:{xs8:""}},[a("v-slider",{attrs:{color:"red",max:"800","inverse-label":"",label:t.image.width+"px"},model:{value:t.image.width,callback:function(e){t.$set(t.image,"width",e)},expression:"image.width"}})],1),a("v-flex",{attrs:{xs4:""}},[a("v-checkbox",{attrs:{color:"red",label:"Fix magasság"},model:{value:t.image.fix_height,callback:function(e){t.$set(t.image,"fix_height",e)},expression:"image.fix_height"}})],1),a("v-flex",{attrs:{xs8:""}},[a("v-slider",{attrs:{color:"red","inverse-label":"",max:"400",label:t.image.height+"px"},model:{value:t.image.height,callback:function(e){t.$set(t.image,"height",e)},expression:"image.height"}})],1),a("v-flex",{attrs:{xs12:"","text-sx-center":""}},[a("v-radio-group",{attrs:{row:""},model:{value:t.image.align,callback:function(e){t.$set(t.image,"align",e)},expression:"image.align"}},[a("v-radio",{attrs:{color:"red",label:"Igazítás balra",value:"content-image-left"}}),a("v-radio",{attrs:{color:"red",label:"Igazítás középre",value:"content-image-center"}}),a("v-radio",{attrs:{color:"red",label:"Igazítás jobbra",value:"content-image-right"}})],1)],1),a("v-flex",{staticClass:"text-xs-center text-sm-center text-md-center text-lg-center",attrs:{xs12:""}},[t.image.url?a("img",{attrs:{src:t.image.url,height:"250"}}):t._e(),a("v-text-field",{attrs:{label:"Kép kiválasztása","prepend-icon":"attach_file"},on:{click:t.pickFile},model:{value:t.image.name,callback:function(e){t.$set(t.image,"name",e)},expression:"image.name"}}),a("input",{ref:"image",staticStyle:{display:"none"},attrs:{type:"file",accept:"image/*"},on:{change:t.onFilePicked}})],1)],1)],1)],1),a("v-card-actions",[a("v-spacer"),a("v-btn",{on:{click:function(e){t.cancelInsertImage()}}},[t._v("Mégsem\n              ")]),a("v-btn",{attrs:{color:"success"},on:{click:function(e){t.insertImage(n.image_ext)}}},[t._v("\n                Beillesztés\n              ")])],1)],1)],1)],1)}}])}),a("editor-content",{attrs:{id:"my-editor",editor:t.editor}}),a("div",{staticClass:"meta"},[a("p",[t._v("Létrehozva: "),a("span",[t._v(t._s(t.createdAt))])]),a("p",[t._v("Utolsó frissítés: "),a("span",[t._v(t._s(t.updatedAt))])])]),a("v-btn",{attrs:{color:"success"},on:{click:function(e){t.sendToServer()}}},[t._v("Mentés")])],1),a("div",[t._v("\n    "+t._s(t.html)+"\n  ")])],1)},Rt=[],Dt=a("768b"),Ht=(a("7f7f"),a("cd42")),Bt=a("f23d"),Jt=a("d225"),Kt=a("b0b4"),Ut=a("308d"),qt=a("6bb5"),Nt=a("4e2b"),Gt=function(t){function e(){return Object(Jt["a"])(this,e),Object(Ut["a"])(this,Object(qt["a"])(e).apply(this,arguments))}return Object(Nt["a"])(e,t),Object(Kt["a"])(e,[{key:"commands",value:function(t){var e=t.type;return function(t){return function(a,n){var o=a.selection,i=o.$cursor?o.$cursor.pos:o.$to.pos,l=e.create(t),s=a.tr.insert(i,l);n(s)}}}},{key:"name",get:function(){return"image_ext"}},{key:"schema",get:function(){return{inline:!0,attrs:{src:{},alt:{default:null},title:{default:null},height:{default:null},width:{default:"200"},class:{default:"content-image-left"}},group:"inline",draggable:!0,parseDOM:[{tag:"img[src]",getAttrs:function(t){return{src:t.getAttribute("src"),title:t.getAttribute("title"),alt:t.getAttribute("alt"),width:t.getAttribute("width"),height:t.getAttribute("height"),class:t.getAttribute("class")}}}],toDOM:function(t){return["img",t.attrs]}}}}]),e}(Ht["f"]),Wt={name:"Post",components:{EditorContent:Ht["b"],EditorMenuBar:Ht["c"]},data:function(){var t=this;return{active:!0,image:{align:"content-image-left",url:"",name:"",file:"",width:400,height:0,alt:"",title:"",fix_width:!0,fix_height:!1},dialog:!1,html:"",editor:new Ht["a"]({extensions:[new Bt["a"],new Bt["f"],new Bt["i"],new Bt["l"],new Bt["c"]({levels:[1,2,3]}),new Bt["b"],new Bt["h"],new Bt["g"],new Bt["j"],new Bt["k"],new Bt["e"],new Bt["d"],new Gt],onUpdate:function(e){var a=e.getHTML;t.html=a(),t.post.attributes.content=a()}}),post:{id:0,attributes:{title:"",blurb:"",content:"",thumbnail_url:""}}}},methods:{insertImage:function(t){var e=this,a="http://206.189.55.142/api/",n=new FormData;n.append("image",this.image.file),ct.a.post("".concat(a,"/embedded_image"),n,{headers:{Authorization:"Bearer ".concat(window.localStorage.getItem("user_token")),Accept:"application/json","Content-Type":"multipart/form-data"}}).then(function(a){console.log("SUCCESS!!"),console.log(a.data.url);var n={src:a.data.url,title:e.image.title,alt:e.image.alt,class:e.image.align};e.image.fix_width&&(n.width="".concat(e.image.width)),e.image.fix_height&&(n.height="".concat(e.image.height)),console.log(n),t(n),e.dialog=!1,e.image={align:"content-image-left",url:"",name:"",file:"",width:400,height:0,alt:"",title:"",fix_width:!0,fix_height:!1}}).catch(function(t){console.log("FAILURE!!"),console.log(t)})},cancelInsertImage:function(){this.dialog=!1},pickFile:function(){this.$refs.image.click()},onFilePicked:function(t){var e=this;console.log("file picked");var a=t.target.files;if(void 0!==a[0]){if(this.image.name=a[0].name,this.image.name.lastIndexOf(".")<=0)return void(this.image.name="");var n=new FileReader;n.readAsDataURL(a[0]),n.addEventListener("load",function(){e.image.url=n.result;var t=Object(Dt["a"])(a,1);e.image.file=t[0]})}else this.image.name="",this.image.file="",this.image.url=""},sendToServer:function(){var t=this,e="http://206.189.55.142/api/",a={type:"posts",attributes:{title:this.post.attributes.title,blurb:this.post.attributes.blurb,content:this.post.attributes.content,thumbnail_url:this.post.attributes.thumbnail_url}};console.log(a),ct.a.patch("".concat(e,"posts/").concat(this.post.id),{data:a},{headers:{Authorization:"Bearer ".concat(window.localStorage.getItem("user_token")),Accept:"application/vnd.api+json","Content-Type":"application/vnd.api+json"}}).then(function(){t.$router.push("/admin/posts")}).catch(function(t){console.log(t.data)})}},computed:{createdAt:function(){return new Date(this.post.attributes.created_at).toLocaleString("hu-HU")},updatedAt:function(){return new Date(this.post.attributes.updated_at).toLocaleString("hu-HU")}},mounted:function(){var t=this;ct.a.get("http://206.189.55.142/api/posts/".concat(this.$route.params.id)).then(function(e){t.post=e.data.data,t.editor.setContent(e.data.data.attributes.content)})},beforeDestroy:function(){this.editor.destroy()}},Zt=Wt,Qt=(a("8904"),a("b0af")),Xt=a("99d9"),Yt=a("12b2"),te=a("ac7c"),ee=a("169a"),ae=a("67b6"),ne=a("43a6"),oe=a("ba0d"),ie=Object(d["a"])(Zt,Pt,Rt,!1,null,"51d504b8",null);ie.options.__file="Post.vue";var le=ie.exports;m()(ie,{VBtn:R["a"],VCard:Qt["a"],VCardActions:Xt["a"],VCardTitle:Yt["a"],VCheckbox:te["a"],VContainer:N["a"],VDialog:ee["a"],VFlex:z["a"],VForm:kt["a"],VIcon:Ft["a"],VLayout:y["a"],VRadio:ae["a"],VRadioGroup:ne["a"],VSlider:oe["a"],VSpacer:G["a"],VTextField:xt["a"]});var se=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-container",[a("v-layout",{attrs:{"align-center":"","justify-center":"",column:"","fill-height":""}},[a("v-form",{ref:"form",attrs:{id:"login-form"},model:{value:t.valid,callback:function(e){t.valid=e},expression:"valid"}},[a("v-flex",{attrs:{xs12:""}},[a("v-text-field",{attrs:{color:"red",rules:[function(t){return!!t||"megadása kötelező!"}],name:"last_name","validate-on-blur":"",label:"Vezetéknév",required:""},model:{value:t.last_name,callback:function(e){t.last_name=e},expression:"last_name"}})],1),a("v-flex",{attrs:{xs12:""}},[a("v-text-field",{attrs:{color:"red",rules:[function(t){return!!t||"megadása kötelező!"}],name:"first_name","validate-on-blur":"",label:"Keresztnév",required:""},model:{value:t.first_name,callback:function(e){t.first_name=e},expression:"first_name"}})],1),a("v-flex",{attrs:{xs12:""}},[a("v-text-field",{attrs:{color:"red",rules:t.emailRules,name:"email","validate-on-blur":"",label:"E-mail",required:""},model:{value:t.email,callback:function(e){t.email=e},expression:"email"}})],1),a("v-flex",{attrs:{xs12:""}},[a("v-text-field",{attrs:{color:"red","append-icon":t.show1?"visibility_off":"visibility",rules:t.passwordRules,type:t.show1?"text":"password",name:"password",label:"Jelszó",counter:""},on:{"click:append":function(e){t.show1=!t.show1}},model:{value:t.password,callback:function(e){t.password=e},expression:"password"}})],1),a("v-checkbox",{attrs:{rules:[function(t){return!!t||""}],label:"Elfogadom az adatvédelmi szabályzatot",required:""},model:{value:t.checkbox,callback:function(e){t.checkbox=e},expression:"checkbox"}}),a("v-flex",{attrs:{xs12:"","text-xs-center":""}},[a("v-btn",{attrs:{"align-self-center":"",disabled:!t.valid,color:"success"},on:{click:t.register}},[t._v("\n          Regisztráció\n        ")])],1)],1)],1)],1)},re=[],ce={name:"Registration",data:function(){return{valid:!0,checkbox:!1,first_name:"",last_name:"",show1:!1,password:"",passwordRules:[function(t){return!!t||"Jelszó megadása kötelező!"},function(t){return t&&t.length>=8||"A jelszó minimum 8 karakter"}],email:"",emailRules:[function(t){return!!t||"E-mail megadása kötelező"},function(t){return/.+@.+/.test(t)||"Hibás email formátum"}]}},methods:{register:function(){var t={email:this.email,password:this.password,first_name:this.first_name,last_name:this.last_name},e="http://206.189.55.142/api/",a="".concat(e,"users");ct.a.post(a,{type:"users",attributes:t},{headers:{Accept:"application/json","Content-Type":"application/vnd.api+json"}}).then(function(t){console.log(t)}).catch(function(t){console.log(t)})}}},ue=ce,de=(a("853d"),Object(d["a"])(ue,se,re,!1,null,"2cdaf5e7",null));de.options.__file="Registration.vue";var ve=de.exports;m()(de,{VBtn:R["a"],VCheckbox:te["a"],VContainer:N["a"],VFlex:z["a"],VForm:kt["a"],VLayout:y["a"],VTextField:xt["a"]}),n["a"].use(it["a"]);var me=new it["a"]({mode:"history",base:"/",routes:[{path:"/",name:"home",component:pt},{path:"/bejelentkezes",name:"login",component:zt},{path:"/regisztracio",name:"registration",component:ve},{path:"/admin/posts",name:"admin-posts",component:Mt},{path:"/oldal/:id",name:"page",component:St},{path:"/admin/posts/:id/edit",name:"admin-posts-edit",component:le},{path:"/about",name:"about",component:function(){return a.e("about").then(a.bind(null,"f820"))}}]});n["a"].config.productionTip=!1,new n["a"]({router:me,render:function(t){return t(ot)}}).$mount("#app")},"5a9d":function(t,e,a){},"5c0b":function(t,e,a){"use strict";var n=a("6879"),o=a.n(n);o.a},"66ef":function(t,e,a){},6879:function(t,e,a){},"6b76":function(t,e,a){},"853d":function(t,e,a){"use strict";var n=a("d2a9"),o=a.n(n);o.a},"86bc":function(t,e,a){"use strict";var n=a("1dbc"),o=a.n(n);o.a},8904:function(t,e,a){"use strict";var n=a("c9fc"),o=a.n(n);o.a},a040:function(t,e,a){"use strict";var n=a("66ef"),o=a.n(n);o.a},ae73:function(t,e,a){"use strict";var n=a("070c"),o=a.n(n);o.a},c9fc:function(t,e,a){},cf05:function(t,e,a){t.exports=a.p+"img/logo.c87358f5.png"},d2a9:function(t,e,a){},e8a8:function(t,e,a){"use strict";var n=a("6b76"),o=a.n(n);o.a},ffa2:function(t,e,a){"use strict";var n=a("5a9d"),o=a.n(n);o.a}});
//# sourceMappingURL=app.138c47fa.js.map
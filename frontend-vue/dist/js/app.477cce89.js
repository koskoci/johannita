(function(t){function e(e){for(var a,o,l=e[0],s=e[1],c=e[2],u=0,d=[];u<l.length;u++)o=l[u],r[o]&&d.push(r[o][0]),r[o]=0;for(a in s)Object.prototype.hasOwnProperty.call(s,a)&&(t[a]=s[a]);f&&f(e);while(d.length)d.shift()();return i.push.apply(i,c||[]),n()}function n(){for(var t,e=0;e<i.length;e++){for(var n=i[e],a=!0,o=1;o<n.length;o++){var l=n[o];0!==r[l]&&(a=!1)}a&&(i.splice(e--,1),t=s(s.s=n[0]))}return t}var a={},o={app:0},r={app:0},i=[];function l(t){return s.p+"js/"+({}[t]||t)+"."+{"chunk-26c8fc77":"8139b447","chunk-2d21a090":"ddc50f35","chunk-590ca522":"3cfb6065","chunk-2d0de7be":"e95d1df7","chunk-6072ae92":"0b4127ee","chunk-6c41f1c5":"be1cdcf3"}[t]+".js"}function s(e){if(a[e])return a[e].exports;var n=a[e]={i:e,l:!1,exports:{}};return t[e].call(n.exports,n,n.exports,s),n.l=!0,n.exports}s.e=function(t){var e=[],n={"chunk-26c8fc77":1,"chunk-6072ae92":1,"chunk-6c41f1c5":1};o[t]?e.push(o[t]):0!==o[t]&&n[t]&&e.push(o[t]=new Promise(function(e,n){for(var a="css/"+({}[t]||t)+"."+{"chunk-26c8fc77":"fb87ccbd","chunk-2d21a090":"31d6cfe0","chunk-590ca522":"31d6cfe0","chunk-2d0de7be":"31d6cfe0","chunk-6072ae92":"6821a65e","chunk-6c41f1c5":"41da6075"}[t]+".css",r=s.p+a,i=document.getElementsByTagName("link"),l=0;l<i.length;l++){var c=i[l],u=c.getAttribute("data-href")||c.getAttribute("href");if("stylesheet"===c.rel&&(u===a||u===r))return e()}var d=document.getElementsByTagName("style");for(l=0;l<d.length;l++){c=d[l],u=c.getAttribute("data-href");if(u===a||u===r)return e()}var f=document.createElement("link");f.rel="stylesheet",f.type="text/css",f.onload=e,f.onerror=function(e){var a=e&&e.target&&e.target.src||r,i=new Error("Loading CSS chunk "+t+" failed.\n("+a+")");i.request=a,delete o[t],f.parentNode.removeChild(f),n(i)},f.href=r;var v=document.getElementsByTagName("head")[0];v.appendChild(f)}).then(function(){o[t]=0}));var a=r[t];if(0!==a)if(a)e.push(a[2]);else{var i=new Promise(function(e,n){a=r[t]=[e,n]});e.push(a[2]=i);var c,u=document.createElement("script");u.charset="utf-8",u.timeout=120,s.nc&&u.setAttribute("nonce",s.nc),u.src=l(t),c=function(e){u.onerror=u.onload=null,clearTimeout(d);var n=r[t];if(0!==n){if(n){var a=e&&("load"===e.type?"missing":e.type),o=e&&e.target&&e.target.src,i=new Error("Loading chunk "+t+" failed.\n("+a+": "+o+")");i.type=a,i.request=o,n[1](i)}r[t]=void 0}};var d=setTimeout(function(){c({type:"timeout",target:u})},12e4);u.onerror=u.onload=c,document.head.appendChild(u)}return Promise.all(e)},s.m=t,s.c=a,s.d=function(t,e,n){s.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:n})},s.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},s.t=function(t,e){if(1&e&&(t=s(t)),8&e)return t;if(4&e&&"object"===typeof t&&t&&t.__esModule)return t;var n=Object.create(null);if(s.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var a in t)s.d(n,a,function(e){return t[e]}.bind(null,a));return n},s.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return s.d(e,"a",e),e},s.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},s.p="/",s.oe=function(t){throw console.error(t),t};var c=window["webpackJsonp"]=window["webpackJsonp"]||[],u=c.push.bind(c);c.push=e,c=c.slice();for(var d=0;d<c.length;d++)e(c[d]);var f=u;i.push([0,"chunk-vendors"]),n()})({0:function(t,e,n){t.exports=n("56d7")},"070c":function(t,e,n){},"1dbc":function(t,e,n){},"29b8":function(t,e,n){},"336c":function(t,e,n){"use strict";var a=n("79bd"),o=n.n(a);o.a},"56d7":function(t,e,n){"use strict";n.r(e);n("cadf"),n("551c"),n("097d");var a=n("2b0e"),o=n("bb71");n("da64");a["a"].use(o["a"],{iconfont:"md"});var r=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-app",[n("v-content",{staticClass:"wrapper"},[n("Navigation"),n("router-view")],1),n("Footer")],1)},i=[],l=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-footer",{attrs:{height:"auto",dark:""}},[n("ul",[n("li",[t._v("Cím: H-1056 Budapest Váci utca 62-64")]),n("li",[t._v("Telefon: +36-1-266-91-30")]),n("li",[t._v("E-mail: info@johannitak.hu")]),n("li",[t._v("Facebook: https://www.facebook.com/johannitak.hu/")]),n("li",[t._v(" ")]),n("li",[t._v("Adószám: 19650768-1-41")]),n("li",[t._v("Főszámlaszáma: OTP BANK Nyrt, 11705008-20410322")]),n("li",[t._v(" ")]),n("li",[t._v("© 2018 - Minden jog fenntartva!")])])])},s=[],c={name:"Footer"},u=c,d=(n("86bc"),n("2877")),f=n("6544"),v=n.n(f),p=n("553a"),m=Object(d["a"])(u,l,s,!1,null,"8b75c426",null);m.options.__file="Footer.vue";var h=m.exports;v()(m,{VFooter:p["a"]});var b=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-container",{attrs:{id:"header"}},[n("v-layout",{attrs:{row:"","justify-end":""}},[n("Profile")],1),n("v-layout",{attrs:{row:"","align-center":""}},[n("v-flex",{attrs:{shrink:""}},[n("router-link",{attrs:{to:"/"}},[n("Logo")],1)],1),n("v-flex",{staticClass:"menu",attrs:{grow:""}},[t.isAdminRoute?n("v-toolbar",{attrs:{flat:"",color:"white"}},[n("v-spacer"),n("v-toolbar-items",[n("v-btn",{attrs:{to:"/admin/dashboard",flat:""}},[t._v("Dashboard")]),n("v-btn",{attrs:{to:"/admin/pages",flat:""}},[t._v("Oldalak")]),n("v-btn",{attrs:{to:"/admin/posts",flat:""}},[t._v("Hirek")]),n("v-btn",{attrs:{to:"/admin/users",flat:""}},[t._v("Felhasznalok")]),n("v-btn",{attrs:{to:"/admin/course_categories",flat:""}},[t._v("Esemény kategóriák")]),n("v-btn",{attrs:{to:"/admin/course_events",flat:""}},[t._v("Tanfolyam események")]),n("v-btn",{attrs:{to:"/admin/courses",flat:""}},[t._v("Tanfolyamok")])],1)],1):n("v-toolbar",{attrs:{id:"public-menu",flat:"",color:"white"}},[n("v-spacer"),n("v-toolbar-items",[n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("A segítő szolgálat")]),n("SubMenu",{attrs:{items:t.menu.rolunk}})],1),n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Tevékenységeink")]),n("SubMenu",{attrs:{items:t.menu.tevekenyseg}})],1),n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Számítunk rád!")]),n("SubMenu",{attrs:{items:t.menu.jelentkezes}})],1),n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Támogatás")]),n("SubMenu",{attrs:{items:t.menu.tamogatas}})],1),n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Johannita Tábor")]),n("SubMenu",{attrs:{items:t.menu.tabor}})],1),n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("Kapcsolat")]),n("SubMenu",{attrs:{items:t.menu.kapcsolat}})],1)],1)],1)],1)],1)],1)},g=[],_=(n("f559"),function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-layout",{attrs:{"align-center":""}},[a("v-flex",[a("img",{attrs:{src:n("cf05"),alt:"johannita logo"}})]),a("v-flex",[a("div",{staticClass:"logo-text"},[a("div",[t._v("Johannita")]),a("div",[t._v("Segítő")]),a("div",[t._v("Szolgálat")])])])],1)}),k=[],y={name:"Logo"},w=y,z=(n("ae73"),n("0e8f")),j=n("a722"),x=Object(d["a"])(w,_,k,!1,null,"1aab42be",null);x.options.__file="Logo.vue";var T=x.exports;v()(x,{VFlex:z["a"],VLayout:j["a"]});var V=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",t._l(t.items,function(e,a){return n("v-list-tile",{key:a,staticClass:"submenu-item",attrs:{to:e.to,"active-class":"active-item"}},[n("v-list-tile-title",[t._v(t._s(e.title))])],1)}),1)},C=[],L={name:"SubMenu",props:["items"]},S=L,E=(n("ffa2"),n("ba95")),P=n("5d23"),M=Object(d["a"])(S,V,C,!1,null,"44c081b4",null);M.options.__file="SubMenu.vue";var O=M.exports;v()(M,{VListTile:E["a"],VListTileTitle:P["b"]});var A=function(){var t=this,e=t.$createElement,n=t._self._c||e;return t.getToken()?n("div",{staticClass:"user-profile-logged-in"},[n("v-menu",{attrs:{"open-on-hover":"","offset-y":""}},[n("v-btn",{attrs:{slot:"activator",flat:""},slot:"activator"},[t._v("\n      "+t._s(t.getEmail())+"\n    ")]),n("v-list",[t._l(t.items,function(e,a){return n("v-list-tile",{key:a,attrs:{to:e.to}},[n("v-list-tile-title",[t._v(t._s(e.title))])],1)}),n("v-divider"),n("v-list-tile",{on:{click:t.logout}},[n("v-list-tile-title",[t._v("Logout")])],1)],2)],1)],1):n("div",{staticClass:"user-profile"},[n("router-link",{attrs:{to:"/bejelentkezes"}},[t._v("Bejelentkezés")]),t._v("\n  /\n  "),n("router-link",{attrs:{to:"/regisztracio"}},[t._v("Regisztráció")])],1)},H=[],$={name:"Profile",data:function(){return{items:[{title:"Profil",to:"#"},{title:"Admin",to:"/admin"}]}},methods:{getToken:function(){return window.localStorage.getItem("user_token")},getEmail:function(){return window.localStorage.getItem("user_email")},logout:function(){window.localStorage.removeItem("user_token"),window.localStorage.removeItem("user_email"),window.location.href="/",console.log("logout")}}},D=$,F=(n("e8a8"),n("8336")),B=n("ce7e"),I=n("8860"),J=n("e449"),N=Object(d["a"])(D,A,H,!1,null,"f398a694",null);N.options.__file="Profile.vue";var R=N.exports;v()(N,{VBtn:F["a"],VDivider:B["a"],VList:I["a"],VListTile:E["a"],VListTileTitle:P["b"],VMenu:J["a"]});var K={name:"Navigation",components:{Logo:T,SubMenu:O,Profile:R},data:function(){return{menu:{rolunk:[{title:"Elnöki köszöntő",to:"/oldal/elnoki_koszonto"},{title:"Rólunk",to:"/oldal/rolunk"},{title:"Helyi szervezetek",to:"/oldal/helyi_szervezetek"},{title:"Közhasznúságú jelentések",to:"/oldal/kozhasznu_jelentesek"},{title:"Aktuális projektek",to:"/oldal/projektek"},{title:"Johanniter International",to:"/oldal/johanniter"}],tevekenyseg:[{title:"Elsősegélynújtás",to:"/oldal/elnoki_koszonto"},{title:"Eszközkölcsönzés",to:"/oldal/eszkozkolcsonzes"},{title:"Hedrehelyi idősek klubja",to:"/oldal/hedrelyi_idosek_kluja"},{title:"Humanitárius segélyezés",to:"/oldal/humanitarius_segelyezes"},{title:"Ifjúsági munka",to:"/oldal/ifjusagi_munka"},{title:"Katasztrófavédelem",to:"/oldal/katasztrofavedelem"},{title:"Mentőszolgálat",to:"/oldal/mentoszolgalat"}],jelentkezes:[{title:"Jelentkezés Képzésre",to:"/oldal/jelentkezes_kepzes"},{title:"Jelentkezes Onkentes Lehetosegekre",to:"/oldal/jelentkezes_onkentes"}],tamogatas:[{title:"Báróti háztűz",to:"/oldal/elnoki_koszonto"},{title:"Elsősegély program",to:"/oldal/rolunk1"},{title:"Guti Óvoda",to:"/oldal/helyi_szervezetek"},{title:"Háromkút Iskolatűz",to:"/oldal/kozhasznu_jelentesek"},{title:"Kárpátalja",to:"/oldal/karpatalja"},{title:"Táti gázrobbanás",to:"/oldal/gazrobbanas_tat"},{title:"Terényi tűz",to:"/oldal/terenyi_tuz"},{title:"Zólyomi család",to:"/oldal/zolyomi_csalad"}],tabor:[{title:"Tábor információk",to:"/oldal/tabor_informaciok"},{title:"Jelentkezés a táborba",to:"/oldal/tabor_jelentkezes"},{title:"A tábor története",to:"/oldal/tabor_tortenet"}],kapcsolat:[{title:"Hírlevel",to:"/oldal/foo_bar"}]}}},computed:{isAdminRoute:function(){return this.$route.path.startsWith("/admin")}}},q=K,U=(n("336c"),n("a523")),G=n("9910"),W=n("71d9"),Z=n("2a7f"),Q=Object(d["a"])(q,b,g,!1,null,"841e9e12",null);Q.options.__file="Navigation.vue";var X=Q.exports;v()(Q,{VBtn:F["a"],VContainer:U["a"],VFlex:z["a"],VLayout:j["a"],VMenu:J["a"],VSpacer:G["a"],VToolbar:W["a"],VToolbarItems:Z["a"]});var Y={name:"App",components:{Footer:h,Navigation:X},data:function(){return{}}},tt=Y,et=(n("5c0b"),n("7496")),nt=n("549c"),at=Object(d["a"])(tt,r,i,!1,null,null,null);at.options.__file="App.vue";var ot=at.exports;v()(at,{VApp:et["a"],VContent:nt["a"]});var rt=n("8c4f"),it=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[t.loading?n("div",{staticClass:"loading"},[t._v("\n    Loading...\n  ")]):t._e(),t.error?n("div",{staticClass:"error"},[t._v("\n    "+t._s(t.error)+"\n  ")]):t._e(),t.posts?n("div",{staticClass:"content"},[n("v-content",[n("v-layout",{attrs:{row:""}},[n("v-flex",{attrs:{xs2:""}}),n("v-flex",{attrs:{xs8:""}},[n("v-timeline",{attrs:{dense:""}},t._l(t.posts,function(e){return n("v-timeline-item",{key:e.id,attrs:{to:"/hirek/1",color:"red",right:"",small:""}},[n("span",{class:"font-weight-bold red--text xs3 post-date-wrapper",attrs:{slot:"opposite"},domProps:{textContent:t._s(new Date(e.attributes.created_at).toLocaleDateString("hu-HU"))},slot:"opposite"}),n("router-link",{attrs:{to:"/hirek/"+e.id}},[n("h2",{class:"headline font-weight-light mb-3 red--text"},[t._v(t._s(e.attributes.title)+"\n                  ")]),n("div",{staticClass:"blurb",domProps:{innerHTML:t._s(e.attributes.blurb)}})])],1)}),1)],1),n("v-flex",{attrs:{xs2:""}})],1)],1)],1):t._e()])},lt=[],st=n("bc3a"),ct=n.n(st),ut={name:"Home",data:function(){return{posts:[]}},created:function(){this.fetchData()},methods:{fetchData:function(){var t=this;this.error=null,this.posts=null,this.loading=!0;var e="http://206.189.55.142/api/",n="".concat(e,"posts");ct.a.get(n,{headers:{Accept:"application/json","Content-Type":"application/vnd.api+json"}}).then(function(e){t.loading=!1,t.posts=e.data.data.reverse()}).catch(function(e){t.loading=!1,t.error=e.response.data.error})}}},dt=ut,ft=(n("6f7b"),n("8414")),vt=n("1e06"),pt=Object(d["a"])(dt,it,lt,!1,null,"334e8b16",null);pt.options.__file="Home.vue";var mt=pt.exports;v()(pt,{VContent:nt["a"],VFlex:z["a"],VLayout:j["a"],VTimeline:ft["a"],VTimelineItem:vt["a"]});var ht=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("v-container",[n("v-layout",{attrs:{"align-center":"","justify-center":"",column:"","fill-height":""}},[n("v-form",{ref:"form",attrs:{id:"login-form"},model:{value:t.valid,callback:function(e){t.valid=e},expression:"valid"}},[n("v-flex",{attrs:{xs12:""}},[n("v-text-field",{attrs:{color:"red",rules:t.emailRules,name:"email","validate-on-blur":"",label:"E-mail",required:""},model:{value:t.email,callback:function(e){t.email=e},expression:"email"}})],1),n("v-flex",{attrs:{xs12:""}},[n("v-text-field",{attrs:{color:"red","append-icon":t.show1?"visibility_off":"visibility",rules:t.passwordRules,type:t.show1?"text":"password",name:"password",label:"Jelszó",counter:""},on:{"click:append":function(e){t.show1=!t.show1}},model:{value:t.password,callback:function(e){t.password=e},expression:"password"}})],1),n("v-flex",{attrs:{xs12:"","text-xs-center":""}},[n("v-btn",{attrs:{"align-self-center":"",disabled:!t.valid,color:"success"},on:{click:t.login}},[t._v("\n          Bejelentkezés\n        ")])],1)],1)],1)],1)},bt=[],gt={name:"Login",data:function(){return{valid:!0,show1:!1,password:"",passwordRules:[function(t){return!!t||"Jelszó megadása kötelező!"},function(t){return t&&t.length>=8||"A jelszó minimum 8 karakter"}],email:"",emailRules:[function(t){return!!t||"E-mail megadása kötelező"},function(t){return/.+@.+/.test(t)||"Hibás email formátum"}]}},methods:{login:function(){var t=this,e="http://206.189.55.142/api/",n="".concat(e,"auth?user=").concat(this.email,"&password=").concat(this.password);ct.a.post(n,null,{headers:{Accept:"application/json","Content-Type":"multipart/form-data"}}).then(function(e){var n=e.data.token;console.log(n),n&&(window.localStorage.setItem("user_email",t.email),window.localStorage.setItem("user_token",n),window.location.href="/")}).catch()}}},_t=gt,kt=(n("a040"),n("4bd4")),yt=n("2677"),wt=Object(d["a"])(_t,ht,bt,!1,null,"049b1971",null);wt.options.__file="Login.vue";var zt=wt.exports;v()(wt,{VBtn:F["a"],VContainer:U["a"],VFlex:z["a"],VForm:kt["a"],VLayout:j["a"],VTextField:yt["a"]});var jt=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[t.loading?n("div",{staticClass:"loading"},[t._v("\n    Loading...\n  ")]):t._e(),t.error?n("div",{staticClass:"error"},[t._v("\n    "+t._s(t.error)+"\n  ")]):t._e(),t.page?n("div",{staticClass:"content"},[n("div",{domProps:{innerHTML:t._s(t.page.attributes.content)}})]):t._e()])},xt=[],Tt={name:"Page",data:function(){return{loading:!1,error:null,page:null}},created:function(){this.fetchData()},watch:{$route:"fetchData"},methods:{fetchData:function(){var t=this;this.error=null,this.page=null,this.loading=!0;var e=this.$route.params.id,n="http://206.189.55.142/api/",a="".concat(n,"pages/").concat(e);ct.a.get(a,{headers:{Accept:"application/json","Content-Type":"application/vnd.api+json"}}).then(function(e){t.loading=!1,t.page=e.data.data}).catch(function(e){t.loading=!1,t.error=e.response.data.error})}}},Vt=Tt,Ct=(n("8738"),Object(d["a"])(Vt,jt,xt,!1,null,"ab3a4170",null));Ct.options.__file="Page.vue";var Lt=Ct.exports,St=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[t.loading?n("div",{staticClass:"loading"},[t._v("\n    Loading...\n  ")]):t._e(),t.error?n("div",{staticClass:"error"},[t._v("\n    "+t._s(t.error)+"\n  ")]):t._e(),t.post?n("div",{staticClass:"content"},[n("h1",{staticClass:"header",domProps:{innerHTML:t._s(t.post.attributes.title)}}),n("h3",{staticClass:"header",domProps:{innerHTML:t._s(new Date(t.post.attributes.created_at).toLocaleDateString("hu-HU"))}}),n("div",{domProps:{innerHTML:t._s(t.post.attributes.content)}})]):t._e()])},Et=[],Pt={name:"Post",data:function(){return{loading:!1,error:null,post:null}},created:function(){this.fetchData()},watch:{$route:"fetchData"},methods:{fetchData:function(){var t=this;this.error=null,this.post=null,this.loading=!0;var e=this.$route.params.id,n="http://206.189.55.142/api/",a="".concat(n,"posts/").concat(e);ct.a.get(a,{headers:{Accept:"application/json","Content-Type":"application/vnd.api+json"}}).then(function(e){t.loading=!1,t.post=e.data.data}).catch(function(e){t.loading=!1,t.error=e.response.data.error})}}},Mt=Pt,Ot=(n("cb07"),Object(d["a"])(Mt,St,Et,!1,null,"8bfc9cce",null));Ot.options.__file="Post.vue";var At=Ot.exports;a["a"].use(rt["a"]);var Ht=new rt["a"]({mode:"history",base:"/",routes:[{path:"/",name:"home",component:mt},{path:"/bejelentkezes",name:"login",component:zt},{path:"/regisztracio",name:"registration",component:function(){return n.e("chunk-6c41f1c5").then(n.bind(null,"6a53"))}},{path:"/oldal/:id",name:"page",component:Lt},{path:"/hirek/:id",name:"post",component:At},{path:"/admin/pages/new",name:"admin-page-new",component:function(){return n.e("chunk-2d0de7be").then(n.bind(null,"869c"))}},{path:"/admin/pages/:id/edit",name:"admin-page",component:function(){return n.e("chunk-2d0de7be").then(n.bind(null,"869c"))}},{path:"/admin/pages",name:"admin-pages",component:function(){return Promise.all([n.e("chunk-26c8fc77"),n.e("chunk-2d21a090")]).then(n.bind(null,"ba94"))}},{path:"/admin/posts",name:"admin-posts",component:function(){return Promise.all([n.e("chunk-26c8fc77"),n.e("chunk-590ca522")]).then(n.bind(null,"4d01"))}},{path:"/admin/posts/:id/edit",name:"admin-post",component:function(){return n.e("chunk-6072ae92").then(n.bind(null,"92fb"))}},{path:"/admin/posts/new",name:"admin-post-new",component:function(){return n.e("chunk-6072ae92").then(n.bind(null,"92fb"))}}]});a["a"].config.productionTip=!1,new a["a"]({router:Ht,render:function(t){return t(ot)}}).$mount("#app")},"5a9d":function(t,e,n){},"5c0b":function(t,e,n){"use strict";var a=n("6879"),o=n.n(a);o.a},"66ef":function(t,e,n){},6879:function(t,e,n){},"6b76":function(t,e,n){},"6cf7":function(t,e,n){},"6f7b":function(t,e,n){"use strict";var a=n("9a7e"),o=n.n(a);o.a},"79bd":function(t,e,n){},"86bc":function(t,e,n){"use strict";var a=n("1dbc"),o=n.n(a);o.a},8738:function(t,e,n){"use strict";var a=n("29b8"),o=n.n(a);o.a},"9a7e":function(t,e,n){},a040:function(t,e,n){"use strict";var a=n("66ef"),o=n.n(a);o.a},ae73:function(t,e,n){"use strict";var a=n("070c"),o=n.n(a);o.a},cb07:function(t,e,n){"use strict";var a=n("6cf7"),o=n.n(a);o.a},cf05:function(t,e,n){t.exports=n.p+"img/logo.c87358f5.png"},e8a8:function(t,e,n){"use strict";var a=n("6b76"),o=n.n(a);o.a},ffa2:function(t,e,n){"use strict";var a=n("5a9d"),o=n.n(a);o.a}});
//# sourceMappingURL=app.477cce89.js.map
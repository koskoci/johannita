(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d21a090"],{ba94:function(t,e,a){"use strict";a.r(e);var n=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("v-toolbar",{attrs:{flat:"",color:"white"}},[a("v-spacer"),a("v-btn",{attrs:{to:"/admin/pages/new",color:"success"}},[t._v("új oldal")])],1),a("v-data-table",{attrs:{headers:t.headers,items:t.pages},scopedSlots:t._u([{key:"items",fn:function(e){return[a("td",[t._v(t._s(e.item.id))]),a("td",[t._v(t._s(e.item.attributes.short_name))]),a("td",[a("v-btn",{attrs:{icon:"",to:"/admin/pages/"+e.item.attributes.short_name+"/edit"}},[a("v-icon",[t._v("edit")])],1),a("v-btn",{attrs:{icon:""},on:{click:function(a){t.deletePage(e.item.attributes.short_name)}}},[a("v-icon",[t._v("delete")])],1)],1)]}}])})],1)},o=[],i=(a("a481"),a("cadf"),a("551c"),a("097d"),a("bc3a")),s=a.n(i),c={name:"Pages",data:function(){return{headers:[{text:"ID",align:"left",value:"id"},{text:"Slug",align:"left",value:"attributes.short_name"},{text:"Opciók",sortable:!1}],pages:[]}},mounted:function(){var t=this;s.a.get("http://206.189.55.142/api/pages").then(function(e){console.log(e.data.data),t.pages=e.data.data})},methods:{deletePage:function(t){confirm("Tényleg törölni szeretnéd a(z) ".concat(t," odalt?"))&&(console.log("Delete page",t),s.a.delete("http://206.189.55.142/api/pages/".concat(t),{headers:{Authorization:"Bearer ".concat(window.localStorage.getItem("user_token")),Accept:"application/vnd.api+json","Content-Type":"application/vnd.api+json"}}).then(function(t){console.log(t),window.location.replace("/admin/pages")}))}}},l=c,r=a("2877"),d=a("6544"),p=a.n(d),u=a("8336"),g=a("8fea"),v=a("132d"),f=a("9910"),h=a("71d9"),m=Object(r["a"])(l,n,o,!1,null,"2209e566",null);m.options.__file="Pages.vue";e["default"]=m.exports;p()(m,{VBtn:u["a"],VDataTable:g["a"],VIcon:v["a"],VSpacer:f["a"],VToolbar:h["a"]})}}]);
//# sourceMappingURL=chunk-2d21a090.7f1ac10f.js.map
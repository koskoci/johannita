(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d21a090"],{ba94:function(t,e,a){"use strict";a.r(e);var n=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("v-toolbar",{attrs:{flat:"",color:"white"}},[a("v-spacer"),a("v-btn",{attrs:{to:"/admin/pages/new",color:"success"}},[t._v("új oldal")])],1),a("v-data-table",{attrs:{headers:t.headers,items:t.pages},scopedSlots:t._u([{key:"items",fn:function(e){return[a("td",[t._v(t._s(e.item.id))]),a("td",[t._v(t._s(e.item.attributes.short_name))]),a("td",[a("v-btn",{attrs:{icon:"",to:"/admin/pages/"+e.item.id+"/edit"}},[a("v-icon",[t._v("edit")])],1),a("v-btn",{attrs:{icon:""},on:{click:function(a){t.deletePage(e.item.id)}}},[a("v-icon",[t._v("delete")])],1)],1)]}}])})],1)},o=[],i=(a("a481"),a("cadf"),a("551c"),a("097d"),a("bc3a")),s=a.n(i),c={name:"Pages",data:function(){return{headers:[{text:"ID",align:"left",value:"id"},{text:"Slug",align:"left",value:"attributes.short_name"},{text:"Opciók",sortable:!1}],pages:[]}},mounted:function(){var t=this;s.a.get("http://206.189.55.142/api/pages").then(function(e){console.log(e.data.data),t.pages=e.data.data})},methods:{deletePage:function(t){confirm("Tényleg törölni szeretnéd a(z) ".concat(t," odalt?"))&&(console.log("Delete page",t),s.a.delete("http://206.189.55.142/api/pages/".concat(t)).then(function(t){console.log(t),window.location.replace("/admin/pages")}))}}},l=c,d=a("2877"),r=a("6544"),u=a.n(r),p=a("8336"),g=a("8fea"),v=a("132d"),f=a("9910"),b=a("71d9"),m=Object(d["a"])(l,n,o,!1,null,"c799b348",null);m.options.__file="Pages.vue";e["default"]=m.exports;u()(m,{VBtn:p["a"],VDataTable:g["a"],VIcon:v["a"],VSpacer:f["a"],VToolbar:b["a"]})}}]);
//# sourceMappingURL=chunk-2d21a090.e4866a8c.js.map
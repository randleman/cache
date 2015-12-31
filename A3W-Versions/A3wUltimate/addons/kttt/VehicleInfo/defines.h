//////////////////////////////////////////////////////////////////////////////////////////////////////////
// this is a edited version of "macro.h" by micovery, including only the basics for Vehicle-Information //
//////////////////////////////////////////////////////////////////////////////////////////////////////////
#define isARRAY(x) \
(not(isNil {x}) && {typeName x == typeName []})

#define isSTRING(x) \
(not(isNil {x}) && {typeName x == typeName ""})

#define isOBJECT(x) \
(not(isNil {x}) && {typeName x == typeName objNull})

#define isNullable(x) (false ||{ \
  not(isNil {x}) &&{ \
  private["_t"]; \
  _t = typeName x; \
  _t == typeName controlNull ||{ \
  _t == typeName displayNull ||{ \
  _t == typeName locationNull ||{ \
  _t == typeName taskNull ||{ \
  _t == typeName grpNull ||{ \
  _t == typeName objNull \
  }}}}}}})

//safer version of isNull that will not crap out when passed number, array, code, string
#define _isNull(x) (isNil {x} || ({isNullable(x) && {isNull x}}))
#define undefined(x) _isNull(x)
#define defined(x) (not(undefined(x)))

#define getIf(cond,v1,v2) \
(if (cond) then {v1} else {v2})

#define OR(x,y) \
getIf(defined(x),x,y)

#define def(x) \
private[#x]

#define init(x,v) def(x); \
x = v

//Assign argument at index o to variable v if it's of type t, else exit with d
#define ARGVX4(o,v,t,d) \
private[#v]; \
if (undefined(_this) ||{ \
   typeName _this != typeName [] ||{ \
   o >= (count _this) ||{ \
   v = _this select o; undefined(v) ||{ \
   (#t != "nil" && {typeName v != typeName t}) \
   }}}}) exitWith { \
  d \
};

//Assign argument at index o, to variable v if it's of type t, else exit with nil
#define ARGVX3(o,v,t) ARGVX4(o,v,t,nil)

#define isClient not(isServer) || {isServer && not(isDedicated)}
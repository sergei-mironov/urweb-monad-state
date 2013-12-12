
(*

building test/Test4.exe
urweb -dbms sqlite ./test/Test4
/home/grwlf/proj/urweb-monad-state/test/Test4.ur:6:40: (to 6:41) Wrong kind
Constructor:  m
  Have kind:  Type
    Need kind:  <UNIF:B> -> <UNIF:C>
    Incompatible kinds
    Kind 1:  Type
    Kind 2:  <UNIF:B> -> <UNIF:C>
    make[1]: *** [test/Test4.exe] Ошибка 1
    make[1]: Выход из каталога `/home/grwlf/proj/urweb-monad-state'
    make: *** [.fix-multy1] Ошибка 2

*)
datatype state m st a = State of (st -> m (st * a))

(*
fun unState [st] [a] ((State f): state st a) : (st -> transaction (st*a)) = f

fun mrun [st] [a] (s:st) (m:state st a) : transaction (st * a) = (unState m) s

fun mreturn [st] [a] (r:a) : state st a = State (fn st => return (st,r))

fun mbind [st] [a] [b] (m1 : state st a) (m2 : a -> state st b) : state st b =
  State (fn (s:st) =>
    r <- (unState m1) s;
    case r of
      (s', va) => unState (m2 va) s')

fun get [st] {} : state st st = State (fn s => return (s,s))

fun set [st] (s:st) : state st {} = State (fn _ => return (s,{}))

val monad = fn [st ::: Type] => mkMonad { Return = @@mreturn [st], Bind = @@mbind [st] }

fun lift [st] [a] (ma:transaction a) : state st a = 
  State (fn (s:st) =>
    a <- ma;
    return (s,a)
    )
*)

fun main {} : transaction page = return <xml><head/><body/></xml>

(* fun main {} : transaction page = *) 
(*   r <- mrun {Val=0} ( *)
(*       s1 <- return 1; *)
(*       s2 <- return (s1 + 1); *)
(*       x <- get {}; *)
(*       set {Val=x.Val+1}; *)
(*       lift (debug "Hello, inner monad"); *)
(*       return (s2+2) *)
(*     ); *)
(*   let *)
(*     val (s,v) = r *)
(*   in *)
(*     return *)
(*       <xml> *)
(*         <head> *)
(*         </head> *)
(*         <body> *)
(*           Urweb-monad test *)
(*           <br/> *)
(*           State value is {[v]} *)
(*           <br/> *)
(*           State itself is {[s.Val]} *)
(*         </body> *)
(*       </xml> *)
(*   end *)


(*————————————————————————————————————————————————————————————————————————————
   Copyright (c) 2021 Craig Ferguson <me@craigfe.io>
   Distributed under the MIT license. See terms at the end of this file.
  ————————————————————————————————————————————————————————————————————————————*)

type ('record, 'data) t
(** The type of runtime representations of OCaml record fields. *)

val get : 'record -> ('record, 'data) t -> 'data
(** [get record field] is [record.field], i.e. the data contained by (the field
    represented by) [field] in [record]. *)

val update : 'record -> ('record, 'data) t -> 'data -> 'record
(** [update record field data] is [{ record with field = data }], i.e. the
    record produced by setting (the field represented by) [field] to [data] in
    [record]. *)

val unsafe_set : 'record -> ('record, 'data) t -> 'data -> unit
(** [unsafe_set record field data] performs [record.field <- data], i.e. updates
    the value of (the field represented by) [field] in [record] to [data].

    NOTE: this results in undefined behaviour if the given record is not
    [mutable]. *)

val index : (_, _) t -> int
(** [index field] is the index of the field represented by [field] in the
    runtime representation of the corresponding record. *)

module O : sig
  val ( .%() ) : 'r -> ('r, 'd) t -> 'd
  (** An operator alias for {!get}. *)

  val ( .%()<- ) : 'r -> ('r, 'd) t -> 'd -> 'r
  (** An operator alias for {!update}. *)

  val ( .%!()<- ) : 'r -> ('r, 'd) t -> 'd -> unit
  (** An operator alias for {!unsafe_set}. *)
end

module Obj : sig
  val unsafe_field_of_index : int -> (_, _) t
  (** Build a record representation from a field {i index} (0 is the first field
      in the runtime representation, 1 is the next field etc.).

      This is obviously horrifically unsafe and should only be used by licensed
      professionals – e.g. as part of a PPX implementation. *)
end

(*————————————————————————————————————————————————————————————————————————————
   Copyright (c) 2021 Craig Ferguson <me@craigfe.io>

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
   DEALINGS IN THE SOFTWARE.
  ————————————————————————————————————————————————————————————————————————————*)

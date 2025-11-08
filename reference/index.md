# Package index

## Rdpack overview

Rdpack overview

- [`Rdpack-package`](https://geobosh.github.io/Rdpack/reference/Rdpack-package.md)
  [`Rdpack`](https://geobosh.github.io/Rdpack/reference/Rdpack-package.md)
  : Update and Manipulate Rd Documentation Objects

## Updating and previewing Rd documentation files

Functions for ensuring that the Rd documentation of functions, methods,
classes and other objects is consistent with their definitions.

- [`RStudio_reprompt()`](https://geobosh.github.io/Rdpack/reference/RStudio_reprompt.md)
  : Call reprompt based on RStudio editor contents
- [`ereprompt()`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
  : Update an Rd file and open it in an editor
- [`reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
  : Update the documentation of a topic
- [`viewRd()`](https://geobosh.github.io/Rdpack/reference/viewRd.md) :
  View Rd files in a source package
- [`promptPackageSexpr()`](https://geobosh.github.io/Rdpack/reference/promptPackageSexpr.md)
  : Generates a shell of documentation for an installed package
- [`Rdo_show()`](https://geobosh.github.io/Rdpack/reference/Rdo_show.md)
  : Convert an Rd object to text and show it
- [`Rdo2Rdf()`](https://geobosh.github.io/Rdpack/reference/Rdo2Rdf.md) :
  Convert an Rd object to Rd file format

## Bibtex references and citations

Bibtex references and citations

- [`Rdpack_bibstyles()`](https://geobosh.github.io/Rdpack/reference/Rdpack_bibstyles.md)
  : Set up a custom style for references in help pages
- [`get_bibentries()`](https://geobosh.github.io/Rdpack/reference/get_bibentries.md)
  : Get all references from a Bibtex file
- [`makeVignetteReference()`](https://geobosh.github.io/Rdpack/reference/makeVignetteReference.md)
  [`vigbib()`](https://geobosh.github.io/Rdpack/reference/makeVignetteReference.md)
  : Make bibtex references for vignettes
- [`rebib()`](https://geobosh.github.io/Rdpack/reference/rebib.md)
  [`inspect_Rdbib()`](https://geobosh.github.io/Rdpack/reference/rebib.md)
  : Work with bibtex references in Rd documentation
- [`insert_all_ref()`](https://geobosh.github.io/Rdpack/reference/insert_all_ref.md)
  : Insert references cited in packages
- [`insert_ref()`](https://geobosh.github.io/Rdpack/reference/insert_ref.md)
  : Insert bibtex references in Rd and roxygen2 documentation
- [`insert_citeOnly()`](https://geobosh.github.io/Rdpack/reference/insert_citeOnly.md)
  : Generate citations from bibtex keys

## Replacing parts of Rd objects

Functions to change Rd contents programmatically

- [`Rdapply()`](https://geobosh.github.io/Rdpack/reference/Rdapply.md)
  [`Rdtagapply()`](https://geobosh.github.io/Rdpack/reference/Rdapply.md)
  [`rattr()`](https://geobosh.github.io/Rdpack/reference/Rdapply.md) :
  Apply a function over an Rd object
- [`Rdreplace_section()`](https://geobosh.github.io/Rdpack/reference/Rdreplace_section.md)
  : Replace the contents of a section in one or more Rd files
- [`Rd_combo()`](https://geobosh.github.io/Rdpack/reference/Rd_combo.md)
  : Manipulate a number of Rd files

## Getting specific parts of Rd objects

Getting specific parts of Rd objects

- [`Rdo_tags()`](https://geobosh.github.io/Rdpack/reference/Rdo_tags.md)
  : Give the Rd tags at the top level of an Rd object
- [`S4formals()`](https://geobosh.github.io/Rdpack/reference/S4formals.md)
  : Give the formal arguments of an S4 method
- [`Rdo_predefined_sections`](https://geobosh.github.io/Rdpack/reference/predefined.md)
  [`Rdo_piece_types`](https://geobosh.github.io/Rdpack/reference/predefined.md)
  [`rdo_top_tags`](https://geobosh.github.io/Rdpack/reference/predefined.md)
  : Tables of predefined sections and types of pieces of Rd objects

## Inspecting Rd objects

Functions for inspection of Rd objects

- [`inspect_Rd()`](https://geobosh.github.io/Rdpack/reference/inspect_Rd.md)
  [`inspect_Rdfun()`](https://geobosh.github.io/Rdpack/reference/inspect_Rd.md)
  [`inspect_Rdmethods()`](https://geobosh.github.io/Rdpack/reference/inspect_Rd.md)
  [`inspect_Rdclass()`](https://geobosh.github.io/Rdpack/reference/inspect_Rd.md)
  : Inspect and update an Rd object or file
- [`inspect_args()`](https://geobosh.github.io/Rdpack/reference/inspect_args.md)
  : Inspect the argument section of an Rd object
- [`inspect_clmethods()`](https://geobosh.github.io/Rdpack/reference/inspect_signatures.md)
  [`inspect_signatures()`](https://geobosh.github.io/Rdpack/reference/inspect_signatures.md)
  : Inspect signatures of S4 methods
- [`inspect_slots()`](https://geobosh.github.io/Rdpack/reference/inspect_slots.md)
  : Inspect the slots of an S4 class
- [`inspect_usage()`](https://geobosh.github.io/Rdpack/reference/inspect_usage.md)
  : Inspect the usage section in an Rd object

## Programming with Rd objects

Functions for use in programmatic manipulation of Rd objects

- [`Rdo_get_argument_names()`](https://geobosh.github.io/Rdpack/reference/Rdo_get_argument_names.md)
  : Get the names of arguments in usage sections of Rd objects
- [`Rdo_get_insert_pos()`](https://geobosh.github.io/Rdpack/reference/Rdo_get_insert_pos.md)
  : Find the position of an "Rd_tag"
- [`Rdo_get_item_labels()`](https://geobosh.github.io/Rdpack/reference/Rdo_get_item_labels.md)
  : Get the labels of items in an Rd object
- [`get_bibentries()`](https://geobosh.github.io/Rdpack/reference/get_bibentries.md)
  : Get all references from a Bibtex file
- [`get_sig_text()`](https://geobosh.github.io/Rdpack/reference/get_sig_text.md)
  : Produce the textual form of the signatures of available methods for
  an S4 generic function
- [`get_usage_text()`](https://geobosh.github.io/Rdpack/reference/get_usage_text.md)
  : Get the text of the usage section of Rd documentation
- [`get_usage()`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
  [`promptUsage()`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
  : Generate usage text for functions and methods

## Parsing Rd objects

Functions for parsing Rd objects

- [`Rdo_reparse()`](https://geobosh.github.io/Rdpack/reference/Rdo_reparse.md)
  : Reparse an Rd object
- [`deparse_usage()`](https://geobosh.github.io/Rdpack/reference/deparse_usage.md)
  [`deparse_usage1()`](https://geobosh.github.io/Rdpack/reference/deparse_usage.md)
  [`as.character(`*`<f_usage>`*`)`](https://geobosh.github.io/Rdpack/reference/deparse_usage.md)
  : Convert f_usage objects to text appropriate for usage sections in Rd
  files
- [`parse_Rdname()`](https://geobosh.github.io/Rdpack/reference/parse_Rdname.md)
  : Parse the name section of an Rd object
- [`parse_Rdpiece()`](https://geobosh.github.io/Rdpack/reference/parse_Rdpiece.md)
  : Parse a piece of Rd source text
- [`parse_Rdtext()`](https://geobosh.github.io/Rdpack/reference/parse_Rdtext.md)
  : Parse Rd source text as the contents of a section
- [`parse_pairlist()`](https://geobosh.github.io/Rdpack/reference/parse_pairlist.md)
  [`pairlist2f_usage1()`](https://geobosh.github.io/Rdpack/reference/parse_pairlist.md)
  : Parse formal arguments of functions
- [`parse_1usage_text()`](https://geobosh.github.io/Rdpack/reference/parse_usage_text.md)
  [`parse_usage_text()`](https://geobosh.github.io/Rdpack/reference/parse_usage_text.md)
  : Parse usage text

## Composing Rd objects

Functions to put together Rd objects

- [`c_Rd()`](https://geobosh.github.io/Rdpack/reference/c_Rd.md) :
  Concatenate Rd objects or pieces
- [`list_Rd()`](https://geobosh.github.io/Rdpack/reference/list_Rd.md) :
  Combine Rd fragments
- [`append_to_Rd_list()`](https://geobosh.github.io/Rdpack/reference/append_to_Rd_list.md)
  : Add content to the element of an Rd object or fragment at a given
  position
- [`char2Rdpiece()`](https://geobosh.github.io/Rdpack/reference/char2Rdpiece.md)
  : Convert a character vector to Rd piece

## Other

Other functions for manipulation of Rd objects

- [`compare_usage1()`](https://geobosh.github.io/Rdpack/reference/compare_usage1.md)
  : Compare usage entries for a function to its actual arguments
- [`format_funusage()`](https://geobosh.github.io/Rdpack/reference/format_funusage.md)
  : Format the usage text of functions
- [`rdo_text_restore()`](https://geobosh.github.io/Rdpack/reference/rdo_text_restore.md)
  : Ensure exported fragments of Rd are as the original
- [`update_aliases_tmp()`](https://geobosh.github.io/Rdpack/reference/update_aliases_tmp.md)
  : Update aliases for methods in Rd objects
- [`Rdo_append_argument()`](https://geobosh.github.io/Rdpack/reference/Rdo_append_argument.md)
  : Append an item for a new argument to an Rd object
- [`Rdo_collect_aliases()`](https://geobosh.github.io/Rdpack/reference/Rdo_collect_metadata.md)
  [`Rdo_collect_metadata()`](https://geobosh.github.io/Rdpack/reference/Rdo_collect_metadata.md)
  : Collect aliases or other metadata from an Rd object
- [`Rdo_empty_sections()`](https://geobosh.github.io/Rdpack/reference/Rdo_empty_sections.md)
  [`Rdo_drop_empty()`](https://geobosh.github.io/Rdpack/reference/Rdo_empty_sections.md)
  : Find or remove empty sections in Rd objects
- [`Rdo_fetch()`](https://geobosh.github.io/Rdpack/reference/Rdo_fetch.md)
  : Get help pages as Rd objects
- [`Rdo_flatinsert()`](https://geobosh.github.io/Rdpack/reference/Rdo_flatinsert.md)
  [`Rdo_flatremove()`](https://geobosh.github.io/Rdpack/reference/Rdo_flatinsert.md)
  : Insert or remove content in an Rd fragment
- [`Rdo_insert()`](https://geobosh.github.io/Rdpack/reference/Rdo_insert.md)
  : Insert a new element in an Rd object possibly surrounding it with
  new lines
- [`Rdo_insert_element()`](https://geobosh.github.io/Rdpack/reference/Rdo_insert_element.md)
  : Insert a new element in an Rd object
- [`Rdo_is_newline()`](https://geobosh.github.io/Rdpack/reference/Rdo_is_newline.md)
  : Check if an Rd fragment represents a newline character
- [`Rdo_locate()`](https://geobosh.github.io/Rdpack/reference/Rdo_locate.md)
  : Find positions of elements in an Rd object
- [`Rdo_locate_leaves()`](https://geobosh.github.io/Rdpack/reference/Rdo_locate_leaves.md)
  : Find leaves of an Rd object using a predicate
- [`Rdo_macro()`](https://geobosh.github.io/Rdpack/reference/Rdo_macro.md)
  [`Rdo_macro1()`](https://geobosh.github.io/Rdpack/reference/Rdo_macro.md)
  [`Rdo_macro2()`](https://geobosh.github.io/Rdpack/reference/Rdo_macro.md)
  [`Rdo_item()`](https://geobosh.github.io/Rdpack/reference/Rdo_macro.md)
  [`Rdo_sigitem()`](https://geobosh.github.io/Rdpack/reference/Rdo_macro.md)
  : Format Rd fragments as macros (todo: a baffling title!)
- [`Rdo_modify()`](https://geobosh.github.io/Rdpack/reference/Rdo_modify.md)
  [`Rdo_replace_section()`](https://geobosh.github.io/Rdpack/reference/Rdo_modify.md)
  : Replace or modify parts of Rd objects
- [`Rdo_modify_simple()`](https://geobosh.github.io/Rdpack/reference/Rdo_modify_simple.md)
  : Simple modification of Rd objects
- [`Rdo_piecetag()`](https://geobosh.github.io/Rdpack/reference/Rdo_piecetag.md)
  [`Rdo_sectype()`](https://geobosh.github.io/Rdpack/reference/Rdo_piecetag.md)
  [`is_Rdsecname()`](https://geobosh.github.io/Rdpack/reference/Rdo_piecetag.md)
  : Give information about Rd elements
- [`Rdo_remove_srcref()`](https://geobosh.github.io/Rdpack/reference/Rdo_remove_srcref.md)
  : Remove srcref attributes from Rd objects
- [`Rdo_sections()`](https://geobosh.github.io/Rdpack/reference/Rdo_sections.md)
  [`Rdo_locate_core_section()`](https://geobosh.github.io/Rdpack/reference/Rdo_sections.md)
  : Locate the sections in Rd objects
- [`Rdo_set_section()`](https://geobosh.github.io/Rdpack/reference/Rdo_set_section.md)
  : Replace a section in an Rd file
- [`Rdo_comment()`](https://geobosh.github.io/Rdpack/reference/Rdo_tag.md)
  [`Rdo_tag()`](https://geobosh.github.io/Rdpack/reference/Rdo_tag.md)
  [`Rdo_verb()`](https://geobosh.github.io/Rdpack/reference/Rdo_tag.md)
  [`Rdo_Rcode()`](https://geobosh.github.io/Rdpack/reference/Rdo_tag.md)
  [`Rdo_text()`](https://geobosh.github.io/Rdpack/reference/Rdo_tag.md)
  [`Rdo_newline()`](https://geobosh.github.io/Rdpack/reference/Rdo_tag.md)
  : Set the Rd_tag of an object
- [`Rdo_which()`](https://geobosh.github.io/Rdpack/reference/Rdo_which.md)
  [`Rdo_which_tag_eq()`](https://geobosh.github.io/Rdpack/reference/Rdo_which.md)
  [`Rdo_which_tag_in()`](https://geobosh.github.io/Rdpack/reference/Rdo_which.md)
  : Find elements of Rd objects for which a condition is true

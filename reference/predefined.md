# Tables of predefined sections and types of pieces of Rd objects

Tables of predefined sections and types of pieces of Rd objects.

## Usage

``` r
Rdo_predefined_sections

Rdo_piece_types

rdo_top_tags
```

## Details

The Rd syntax defines several tables (Murdoch 2010) . Rdpack stores them
in the variables described here.

`Rdo_predefined_sections` is a named character vector providing the
types of the top level sections in an Rd object.

`Rdo_piece_types` is a named character vector giving the types of the
core (all possible?) Rd macros.

**NOTE:** These objects are hard coded and need to be updated if the
specifications of the Rd format are updated.

todo: write functions that go through existing Rd documentation to
discover missing or wrong items.

## Value

for `Rdo_predefined_sections`, the name-value pairs are given in the
following table. For example, `Rdo_predefined_sections["examples"]`
results in RCODE .

|         |      |     |             |       |
|---------|------|-----|-------------|-------|
| name    | VERB | \|  | description | TEXT  |
| alias   | VERB | \|  | examples    | RCODE |
| concept | TEXT | \|  | usage       | RCODE |
| docType | TEXT | \|  | Rdversion   | VERB  |
| title   | TEXT | \|  | synopsis    | VERB  |
| name    | VERB | \|  | section     | TEXT  |
| alias   | VERB | \|  | arguments   | TEXT  |
| concept | TEXT | \|  | keyword     | TEXT  |
| docType | TEXT | \|  | note        | TEXT  |
| title   | TEXT | \|  | format      | TEXT  |
| name    | VERB | \|  | source      | TEXT  |
| alias   | VERB | \|  | details     | TEXT  |
| concept | TEXT | \|  | value       | TEXT  |
| docType | TEXT | \|  | references  | TEXT  |
| title   | TEXT | \|  | author      | TEXT  |
| name    | VERB | \|  | seealso     | TEXT  |

for `Rdo_piece_types`, the name-value pairs are:

|          |       |             |       |              |       |              |       |                 |       |                |      |
|----------|-------|-------------|-------|--------------|-------|--------------|-------|-----------------|-------|----------------|------|
| name     | VERB  | \| alias    | VERB  | \| concept   | TEXT  | docType      | TEXT  | \| title        | TEXT  | \| description | TEXT |
| examples | RCODE | \| usage    | RCODE | \| Rdversion | VERB  | synopsis     | VERB  | \| Sexpr        | RCODE | \| RdOpts      | VERB |
| code     | RCODE | \| dontshow | RCODE | \| donttest  | RCODE | testonly     | RCODE | \| dontrun      | VERB  | \| env         | VERB |
| kbd      | VERB  | \| option   | VERB  | \| out       | VERB  | preformatted | VERB  | \| samp         | VERB  | \| special     | VERB |
| url      | VERB  | \| verb     | VERB  | \| deqn      | VERB  | eqn          | VERB  | \| renewcommand | VERB  | \| newcommand  | VERB |

for `rdo_top_tags`, the values are:

|          |            |              |             |               |
|----------|------------|--------------|-------------|---------------|
| \name    | \Rdversion | \docType     | \alias      | \encoding     |
| \concept | \title     | \description | \usage      | \format       |
| \source  | \arguments | \details     | \value      | \references   |
| \section | \note      | \author      | \seealso    | \examples     |
| \keyword | `#`ifdef   | `#`ifndef    | \newcommand | \renewcommand |
| COMMENT  | TEXT       | ”            | ”           | ”             |

Note that most, but not all, are prefixed with a backslash.

## References

Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.

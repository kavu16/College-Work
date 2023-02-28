/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     EOL = 258,
     L_BRACKET = 259,
     R_BRACKET = 260,
     FACTORIAL = 261,
     GBP_TO_USD = 262,
     USD_TO_GBP = 263,
     GBP_TO_EURO = 264,
     EURO_TO_GBP = 265,
     EURO_TO_USD = 266,
     USD_TO_EURO = 267,
     CEL_TO_FAH = 268,
     FAH_TO_CEL = 269,
     MI_TO_KM = 270,
     KM_TO_MI = 271,
     SQRT = 272,
     ABS = 273,
     FLOOR = 274,
     CEIL = 275,
     COS = 276,
     SIN = 277,
     TAN = 278,
     LOG2 = 279,
     LOG10 = 280,
     ADD = 281,
     SUB = 282,
     MUL = 283,
     DIV = 284,
     POW = 285,
     MOD = 286,
     VAR_KEYWORD = 287,
     EQUALS = 288,
     NUMBER = 289,
     PI = 290,
     VARIABLE = 291
   };
#endif
/* Tokens.  */
#define EOL 258
#define L_BRACKET 259
#define R_BRACKET 260
#define FACTORIAL 261
#define GBP_TO_USD 262
#define USD_TO_GBP 263
#define GBP_TO_EURO 264
#define EURO_TO_GBP 265
#define EURO_TO_USD 266
#define USD_TO_EURO 267
#define CEL_TO_FAH 268
#define FAH_TO_CEL 269
#define MI_TO_KM 270
#define KM_TO_MI 271
#define SQRT 272
#define ABS 273
#define FLOOR 274
#define CEIL 275
#define COS 276
#define SIN 277
#define TAN 278
#define LOG2 279
#define LOG10 280
#define ADD 281
#define SUB 282
#define MUL 283
#define DIV 284
#define POW 285
#define MOD 286
#define VAR_KEYWORD 287
#define EQUALS 288
#define NUMBER 289
#define PI 290
#define VARIABLE 291




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 15 "bse4289.calc1.y"
{
    double dval;
    std::string* sval;
    /* You may include additional fields as you want. */
    /* char op; */
}
/* Line 1529 of yacc.c.  */
#line 128 "bse4289.calc1.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;


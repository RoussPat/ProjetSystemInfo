/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tADD = 258,
    tSUB = 259,
    tMUL = 260,
    tDIV = 261,
    tPV = 262,
    tV = 263,
    tCP = 264,
    tOP = 265,
    tOB = 266,
    tCB = 267,
    tOA = 268,
    tCA = 269,
    tIE = 270,
    tSE = 271,
    tSUP = 272,
    tINF = 273,
    tEQ = 274,
    tAFC = 275,
    tNBFLOAT = 276,
    tTRUE = 277,
    tFALSE = 278,
    tMAIN = 279,
    tPRINTF = 280,
    tCONST = 281,
    tINT = 282,
    tFLOAT = 283,
    tBOOL = 284,
    tCHAR = 285,
    tNOT = 286,
    tNEQ = 287,
    tIF = 288,
    tWHILE = 289,
    tRETURN = 290,
    tQ = 291,
    tNBINT = 292,
    tVAR = 293
  };
#endif
/* Tokens.  */
#define tADD 258
#define tSUB 259
#define tMUL 260
#define tDIV 261
#define tPV 262
#define tV 263
#define tCP 264
#define tOP 265
#define tOB 266
#define tCB 267
#define tOA 268
#define tCA 269
#define tIE 270
#define tSE 271
#define tSUP 272
#define tINF 273
#define tEQ 274
#define tAFC 275
#define tNBFLOAT 276
#define tTRUE 277
#define tFALSE 278
#define tMAIN 279
#define tPRINTF 280
#define tCONST 281
#define tINT 282
#define tFLOAT 283
#define tBOOL 284
#define tCHAR 285
#define tNOT 286
#define tNEQ 287
#define tIF 288
#define tWHILE 289
#define tRETURN 290
#define tQ 291
#define tNBINT 292
#define tVAR 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 6 "compiler.y" /* yacc.c:1909  */

    int nb;
    char* str;

#line 135 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

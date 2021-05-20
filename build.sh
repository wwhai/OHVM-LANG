echo "build...."
lex ohvmlang.l && yacc -d ohvmlang.y && cc lex.yy.c y.tab.c -ll
echo "done."
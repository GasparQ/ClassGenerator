#!/bin/bash

if [ $# -lt 1 ]; then
    echo -e "\e[0;31mUsage : newClass classname\e[0m"
    exit 42
fi

if [ $# -ge 2 ] && [ "$1" = "-i" ]; then
    interface=1
    shift 1
else
    interface=0
fi

filename="$1.hh"
classimpfile="$1.cpp"

generateFullClass()
{
    echo -e "class\t$1" >> "$filename";
    echo -e "{" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tEnums" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tCtor Dtor" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tAttributes" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "private:\n" >> "$filename";
    echo -e "protected:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tMethods" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "private:\n" >> "$filename";
    echo -e "protected:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tGetters" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tSetters" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tOperators" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "  /*" >> "$filename";
    echo -e "  **\tTranstyping" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n" >> "$filename";
    echo -e "};\n" >> "$filename";
}

generateInterface()
{
    echo -e "class\t$1" >> "$filename";
    echo -e "{" >> "$filename";
    echo -e "public:" >> "$filename";
    echo -e "  virtual ~$1(){}" >> "$filename";
    echo -e "\n  /*" >> "$filename";
    echo -e "  **\tMethods" >> "$filename";
    echo -e "  */" >> "$filename";
    echo -e "public:\n\nprivate:\n\nprotected:\n" >> "$filename";
    echo -e "};" >> "$filename"
}

if [ -f "$filename" ]; then
    echo -ne "\e[0;33m";
    read -p "File '$filename' already exists. Do you want to overwrite this file (y/n) : " -n 1 answer
    echo -e "\e[0m";
    if [ "$answer" != "y" ]; then
	echo -e "\e[0;31mClass $1 was not overwrited\e[0m";
	exit 42
    fi
fi

if [ ! -f "$classimpfile" ] && [ $interface -eq 0 ]; then
    echo "#include \"$filename\"" > "$classimpfile"
    echo -e "\e[0;35m$classimpfile create\e[0m"
fi

macro="`echo "$1_H_" | tr '[:lower:]' '[:upper:]'`"

echo -e "#ifndef $macro\n# define $macro\n" > "$filename";

if [ $interface -eq 0 ]; then
    generateFullClass "$1";
else
    generateInterface "$1";
fi

echo -e "#endif\t/* !$macro */\n" >> "$filename";

echo -e "\e[0;32mClass $1 created in file $filename\e[0m";

#!/bin/bash

# Script para compilar correctamente el documento LaTeX con bibliografías
# Autor: Creado para facilitar la compilación del paper

echo "=== Compilando documento LaTeX con bibliografías ==="

# Paso 1: Primera compilación
echo "Paso 1/4: Primera compilación con pdflatex..."
pdflatex main.tex

# Verificar si la primera compilación fue exitosa
if [ $? -ne 0 ]; then
    echo "❌ Error en la primera compilación. Revisa los errores de LaTeX."
    exit 1
fi

# Paso 2: Procesar bibliografía
echo "Paso 2/4: Procesando bibliografía con bibtex..."
bibtex main

# Verificar si bibtex fue exitoso
if [ $? -ne 0 ]; then
    echo "❌ Error al procesar la bibliografía. Revisa el archivo .bib."
    exit 1
fi

# Paso 3: Segunda compilación
echo "Paso 3/4: Segunda compilación con pdflatex..."
pdflatex main.tex

# Paso 4: Tercera compilación (final)
echo "Paso 4/4: Tercera compilación final con pdflatex..."
pdflatex main.tex

# Verificar éxito
if [ $? -eq 0 ]; then
    echo "✅ ¡Compilación completada exitosamente!"
    echo "📄 PDF generado: main.pdf"
    echo ""
    echo "Archivos auxiliares creados:"
    echo "- main.aux (información de referencias cruzadas)"
    echo "- main.bbl (bibliografía procesada)"
    echo "- main.blg (log de bibtex)"
    echo "- main.log (log de compilación)"
else
    echo "❌ Error en la compilación final."
    exit 1
fi

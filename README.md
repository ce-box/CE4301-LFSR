# CE4301 - Generador de n煤meros pseudo-aleatorios 馃幉

Generador de n煤meros pseudo aleatorios utilizando el algoritmo _linear-feedback shift register_ (LFSR), en su variante fibonacci.

## Requisitos 馃搵

Para correr el c贸digo de ejemplo debe tener instalado en su computador un simulador de lenguaje ensamblador. Le recomendamos utilizar el simulador de procesador `RISC-V` : [Ripes](https://github.com/mortbopet/Ripes/releases).

El simulador Ripes se encuentra disponible para Windows, MacOS y Linux. Consulte las instrucciones de instalaci贸n [aqu铆](https://github.com/mortbopet/Ripes/blob/master/README.md).


## Primeros pasos 馃殌

Para correr el programa:

1. Abra el simulador de `RISC-V` Ripes.
2. Para cargar el archivo `File > Load Program` y seleccione el archivo `lfsr_ealvarado_v2.s`.
3. En la pesta帽a **Editor** podr谩 revisar el c贸digo fuente. El valor de la semilla viene por defecto en `0x56` que es el ASCII de la letra _V_. Para cambiarlo coloque el valor de semilla que desee:

```gas:
start:
    li a1,<hex value>
```

4. Finalmente, corra el programa haciendo click en el **bot贸n de play** que se ubica en la barra superior. Podr谩 ver los resultados en la tabla de registros o en la pesta帽a **Memory**.

![demo](assets/demo1.png)

## Algoritmo LFSR 馃捑

El generador LFSR tiene m煤ltiples aplicaciones en criptograf铆a, videojuegos, simulaci贸n y otros. El generador obtiene n煤meros en un orden secuencial aleatorio:

1. Se inicia con un valor semilla.
2. Se toman los bits de las posiciones (`tab`) dadas por el polinomio y se les aplica la operaci贸n `xor`.
3. Se realiza un `shift left` para descartar el `LSB`.
4. Se ingresa el bit resultante en la posici贸n del `MSB`.



La implementaci贸n del c贸digo en C para 8 bits, utilizando el polinomio:
![lfsr](assets/lfsr.png)

```c
// C贸digo completo: lfsr_ealvarado_v2.c

void lfsr_fibonacci(void) {
    
    uint8_t seed_value = 0x56;  
    uint8_t lfsr_value = seed_value;
    uint8_t bit;    
    int counter = 0;

    do
    {   // taps: 6 5; feedback polynomial: x^6 + x^5 + 1 
        bit = ((lfsr_value >> 2) ^ (lfsr_value >> 3)) & 1;
        lfsr_value = (lfsr_value >> 1) | (bit << 7);
        counter++;
    }
    while (counter < 100);
    
    printf("result -> %d\n",lfsr_value);
}
```

El c贸digo en el archivo `lfsr_ealvarado_v2.s` implementa este algoritmo en ensamblador utilizando el set de instrucciones `RISC-V`.

## Autor 馃枊

* **Esteban Alvarado** - *Software Developer* - [@estalvgs1999](https://github.com/estalvgs1999)

> Este proyecto fue desarrollado para el **curso CE4301 - Arquitectura de Computadores I** del Instituto Tecnol贸gico de Costa Rica. 2021 馃劘

Agradecimiento al profesor del curso:

* Prof. Luis Alberto Chavarr铆a Zamora

----

<p align="center">
<img src="https://static.platzi.com/media/achievements/badge-programacion-microcontroladores-pic-c-d3093418-a0e3-4b95-a6c2-77cf06af37f9.png" width="100"/>
</p>

# Ecogrid
A Processing project that attempts to simulate natural selection and evolution
The project can be run with the Processing enviroment.
The linux build doesnt require Processing however and is significantly faster

## Inroduction
### The Enviroment
The simulation enviroment is a grid of cells, each of which represents a primary food source. The cells' maximum level of food
it holds is defined by a map generated with perlin noise. The greener the cell is, the more food it contains. Cells' food amount starts at max, and is decreased when creatures eat the food. The food amount then slowly regenerates until it reaches the max level. 

### The Creatures

#### During each frame, the creatures take the following actions:
1. **reproduce** if their **nutrition** is above the birth limit
2. **select a target** from the 9 cells around it. Involves **decision making**.
3. **move** to their target cell. Consumes some **nutrition**.
4. **attack** every other creature that has a lower **strength** in their cell and gain their **nutrition**
5. **eat** some food from the cell and gain **nutrition**
6. **starve** and die if their **nutrition** goes below zero

#### Creatures have the following mutable attributes, or 'genes':

Decision making:
* **Food weight**: how they are attracted to food
* **Smaller creature weight**: how they are attracted to smaller creatures
* **Bigger creature weight**: how they are attracted to bigger creatures
* **Birth limit**: at which nutrition level they reproduce.

Physical:
* **Eat rate**: affects the amount of food they consume per frame
* **Eat efficiency**: affects the amount of nutrition they gain from eating a certain amount of food
* **Move efficiency**: affects the amount of nutrition consumed by moving
* **Strength multiplier**: affects the total **strength** of a creature

The sum of physical attributes' is normalized to zero, meaning that creatures have to 'decide' which physical attributes they prioritise. For example, if a mutation results in an increase of Strength multiplier, other physical attributes have their final values decreased. This feature allows for different survival 'strategies' to emerge. Without this all attributes would be maxed out quickly resulting in all creatures being almost identical.

Cosmetic:
* **Color**
* **Shape**

#### Secondary attributes (not passed to offspring):

* **Nutrition**: self-explanatory
* **Strength**: creatures nutrition multiplied by **Strength multiplier**. Higher strength allows them to eat bigger creatures and not get eaten so easily
* **Size**: the visible size of the creature, defined by its current **nutrition**

#### Decision making
is simple: each of the 9 cells around the creature is evaluated by summing together
* The amount of food in the cell multiplied by **Food weight**
* The number of smaller creatures in the cell multiplied by **Smaller creature weight**
* The number of bigger creatures in the cell multiplied by **Bigger creature weight**

the cell with the highest weight value is then selected as the target.

#### Reproducing
is also simple: a new creature is created with exactly 1/3 of the nutrition of the parent. The parents nutrition is also decreased by 1/3. The new creatures genetic attributes are copied from the parent and each is randomly mutated slightly.

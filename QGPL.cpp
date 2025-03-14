#include "simulation/ElementCommon.h"
#include "FIRE.h"
#include <cstdlib>

static void create(ELEMENT_CREATE_FUNC_ARGS);
int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_QGPL() {
  Identifier = "MRSMILEY006_PT_QGPL";
  Name = "QGPL";
  Colour = 0xBB99FF_rgb;
  MenuVisible = 1;
  MenuSection = SC_NUCLEAR;
  Enabled = 1;
  Advection = 0.6f;
  AirDrag = 0.04f * CFDS;
  AirLoss = 0.98f;
  Loss = 0.25f;
  Collision = 0.0f;
  Gravity = 0.1f;
  Diffusion = 0.25f;
  HotAir = 0.000f * CFDS;
  Falldown = 2;

  Flammable = 0;
  Explosive = 0;
  Meltable = 0;
  Hardness = 20;
  Weight = 30;

  DefaultProperties.temp = MAX_TEMP;
  HeatConduct = 5;
  Description = "Quark-gluon plasma";

  Properties = TYPE_GAS|PROP_LIFE_DEC|PROP_LIFE_KILL_DEC;

  LowPressure = IPL;
  LowPressureTransition = NT;
  HighPressure = IPH;
  HighPressureTransition = NT;
  LowTemperature = MAX_TEMP - 10;
  LowTemperatureTransition = PT_PLSM;
  HighTemperature = ITH;
  HighTemperatureTransition = NT;

  Update = &Element_FIRE_update;
  Graphics = &graphics;
  Create = &create;
}

int graphics(GRAPHICS_FUNC_ARGS) {
  *colr += rand() % 127 + 1;
  *colg += rand() % 127 + 1;
  *colb += rand() % 127 + 1;
  return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS) {
  sim->parts[i].life = 99999;
}

#include "cpu.h"
#include "sketchybar.h"
#include <stdio.h>

struct cpu g_cpu;

int main(int argc, char **argv) {
  float update_freq = 1;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    printf("Usage: helper \"<event-name>\" \"<update_freq>\"\n");
    exit(1);
  }
  cpu_init(&g_cpu);

  char event_message[512];
  snprintf(event_message, 512, "--add event %s", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
    if (getppid() == 1)
      exit(0);
    cpu_update(&g_cpu);
    snprintf(trigger_message, 512, "--trigger %s INFO=%d", argv[1],
             g_cpu.load_percentage);

    sketchybar(trigger_message);
    usleep(update_freq * 1000000);
  }
  return 0;
}

<template>

  <div class="flex  w-[620px] justify-center items-center gap-3">
    <div class="font-bold">Etape{{ value + 1 }}/{{ max + 1 }}</div>
     <div class="bg-white text-amber-100 h-2 w-3xl">
        <progress :value="value" :max="max"/>

     </div>
  </div>
</template>
<script setup>
const promps = defineProps({
  value: Number,
  max: Number
})
</script>
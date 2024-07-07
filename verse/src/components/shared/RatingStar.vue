<script setup>
defineProps({
  id: Number,
  percentage: Number,
  size: Number
})
</script>

<template>
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" :width="`${size}px`" :height="`${size}px`"
    viewBox="0 0 32 32">
    <defs>
      <linearGradient :id="`rating-${id}`">
        <stop :offset="`${Math.max(0, percentage)}%`" stop-color="#fcd34d" />
        <stop :offset="`${Math.min(100, percentage)}%`" stop-color="white" />
      </linearGradient>
    </defs>
    <path :fill="`url(#rating-${id})`" 
      d="M20.388,10.918L32,12.118l-8.735,7.749L25.914,31.4l-9.893-6.088L6.127,31.4l2.695-11.533L0,12.118 l11.547-1.2L16.026,0.6L20.388,10.918z" 
      stroke-width="1.5px"
      stroke="black"  
    />
  </svg>
</template>

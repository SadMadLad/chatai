<script setup>
import CollectionMap from "@/components/collection/CollectionMap.vue";
import { PhX, PhSpinnerGap } from "@phosphor-icons/vue";
import { ref, watch } from "vue";
import { useCollectableDialogStore } from "@/storage/collectable_dialog";

const {
  closeDialog,
  computedIsDialogOpen,
  computedIsProcessing,
  computedCollectionMaps,
} = useCollectableDialogStore();
const dialog = ref();

watch(computedIsDialogOpen, (isDialogOpen) => {
  if (isDialogOpen) dialog.value?.showModal();
  else dialog.value?.close();
});
</script>

<template>
  <dialog ref="dialog" class="fixed rounded-lg max-w-xs">
    <div class="h-full w-full p-8">
      <PhX
        class="absolute right-4 top-4 cursor-pointer"
        size="20"
        @click="closeDialog"
      />
      <PhSpinnerGap
        class="animate-spin"
        v-if="computedIsProcessing"
        :size="32"
      />
      <div v-else>
        <h4 class="text-xl font-bold">Add to Collection</h4>
        <CollectionMap
          v-for="collectionMap in computedCollectionMaps"
          v-bind="collectionMap"
          v-model="collectionMap.collected"
        />
      </div>
    </div>
  </dialog>
</template>

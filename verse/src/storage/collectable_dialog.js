import { computed, ref, watch } from "vue";
import { defineStore } from "pinia";
import { getCollectableMaps } from "@/services/apis/collectable_map";

const useCollectableDialogStore = defineStore("collectable_dialog", () => {
  // Refs
  const collectableItemTitle = ref(null);
  const collectableItemId = ref(null);
  const collectableItemType = ref(null);
  const collectionMaps = ref([]);
  const isDialogOpen = ref(false);
  const isProcessing = ref(false);

  // Computed
  const computedCollectableItemId = computed(() => collectableItemId);
  const computedCollectableItemType = computed(() => collectableItemType);
  const computedCollectionMaps = computed(() => collectionMaps);
  const computedIsDialogOpen = computed(() => isDialogOpen);
  const computedIsProcessing = computed(() => isProcessing);
  const computedItemTitle = computed(() => collectableItemTitle);

  // Methods
  const openDialog = () => (isDialogOpen.value = true);
  const closeDialog = () => (isDialogOpen.value = false);

  function setItemData(itemId, itemTitle, itemType) {
    collectableItemId.value = itemId;
    collectableItemTitle.value = itemTitle;
    collectableItemType.value = itemType;
  }

  // Watchers
  watch(
    [collectableItemId, collectableItemType],
    async ([newItemId, newItemType]) => {
      isProcessing.value = true;
      try {
        const response = await getCollectableMaps({
          collectable_id: newItemId,
          collectable_type: newItemType,
        });
        collectionMaps.value = await response.json();
      } catch (e) {
        console.log(e);
      } finally {
        isProcessing.value = false;
      }
    },
  );

  return {
    closeDialog,
    computedCollectableItemId,
    computedCollectableItemType,
    computedCollectionMaps,
    computedIsDialogOpen,
    computedItemTitle,
    computedIsProcessing,
    openDialog,
    setItemData,
  };
});

export { useCollectableDialogStore };

<script setup>
import { createFavorite, destroyFavorite } from "@/services/apis/favorite";
import { PhHeart, PhSpinnerGap } from "@phosphor-icons/vue";
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "@/storage/auth";

const { logout } = useAuthStore();
const router = useRouter();

const favorited = defineModel("favorited");
const favoritesCount = defineModel("favoritesCount");

const { favoritableId, favoritableType, hasFavoritesCount } = defineProps({
  favoritableId: Number,
  favoritableType: String,
  favorites_count: Number,
  hasFavoritesCount: Boolean,
  iconSize: Number,
  styleClass: String,
});

const isProcessing = ref(false);
const error = ref(null);

async function favorite() {
  const body = {
    favoritable_id: favoritableId,
    favoritable_type: favoritableType,
  };
  try {
    isProcessing.value = true;
    const response =
      favorited.value === true
        ? await destroyFavorite(body)
        : await createFavorite(body);

    if (response.status === 401) {
      logout();
      router.push({ name: "login" });
    } else {
      if (hasFavoritesCount) {
        favorited.value === true
          ? favoritesCount.value--
          : favoritesCount.value++;
      }
      favorited.value = !favorited.value;
    }
  } catch (e) {
    error.value = e;
  } finally {
    isProcessing.value = false;
  }
}
</script>

<template>
  <span class="flex flex-col items-center gap-0">
    <PhSpinnerGap
      class="animate-spin"
      v-if="isProcessing"
      :size="iconSize || 32"
    />
    <PhHeart
      v-else
      class="cursor-pointer drop-shadow"
      :class="styleClass"
      :weight="favorited ? 'fill' : 'duotone'"
      :size="iconSize || 32"
      @click.stop="favorite"
    />
    <span v-if="hasFavoritesCount" class="text-xs" :class="styleClass">{{
      favoritesCount
    }}</span>
  </span>
</template>

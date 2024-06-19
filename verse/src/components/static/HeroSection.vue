<template>
  <section>
    <div class="flex items-center">
      <div class="flex flex-col items-start gap-4 w-2/3">
        <h2 class="text-4xl font-black text-primary-500">Quiz Shop</h2>
        <div>
          <p class="text-xl text-primary-700">Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, dignissimos.</p>
          <RouterLink :to="{ name: 'quizzes' }">
            <button class="font-semibold bg-primary-500 hover:bg-secondary-500 text-white px-3.5 py-2.5 rounded">Explore Quizzes</button>
          </RouterLink>
        </div>
      </div>
      <div class="w-1/3 bg-primary-500 border">
        <div class="bg-white pl-8">
          <img src="/hero-image.svg" class="w-[40rem] h-auto"/>
        </div>
      </div>
    </div>
  </section>
</template>

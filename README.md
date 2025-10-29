# Pokémon Copy

A fan-made, educational iOS game built with **SwiftUI** and **SpriteKit**, inspired by the classic Pokémon games. Explore maps, encounter wild creatures, and battle in a turn-based system — all while learning game development fundamentals on iOS.

---
## 📸 Gameplay Demos

<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">

<div style="flex: 0 0 48%; margin-bottom: 10px;">
<img src="Pokemon_Copy/ExploreDemo.mov" alt="Walking Animation" width="100%">
</div>

<div style="flex: 0 0 48%; margin-bottom: 10px;">
<img src="Pokemon_Copy/BoundaryDemo.mov" alt="Battle Scene" width="100%">
</div>

<div style="flex: 0 0 48%; margin-bottom: 10px;">
<img src="Pokemon_Copy/RandomEncounterDemo.mov" alt="Random Encounter" width="100%">
</div>

<div style="flex: 0 0 48%; margin-bottom: 10px;">
<img src="Pokemon_Copy/BattleDemo.mov" alt="Map Exploration" width="100%">
</div>

</div>

---

## 🎮 About

Pokémon Copy lets players wander a tile-based map, trigger random encounters in dark grass, and engage in turn-based battles. The goal of this project was **to explore SpriteKit and game logic**, translating concepts from a JavaScript/HTML Canvas tutorial into Swift, and creating a playable experience entirely programmatically.

Key features include:

- **Tile-based exploration** with proper map borders  
- **Walking animations** for the player character  
- **Random encounters** in designated areas  
- **Turn-based battles** with selectable moves (e.g., Tackle, Fireball)  
- **Background/foreground layering** for immersion  
- **Physics-based collision detection** to handle movement and map boundaries  

---

## ⚙️ Technologies Used

- **Swift**  
- **SwiftUI** for menus and UI elements  
- **SpriteKit** for animations and physics  
- Fully **programmatic scene setup** (no scene editor)  

---

## 🧩 Development Highlights

This project was inspired by the YouTube tutorial “[Pokémon JavaScript Game Tutorial with HTML Canvas](https://www.youtube.com/@ChrisCourses)” by Chris Courses. Translating JavaScript logic into Swift and SpriteKit required creativity and problem-solving, particularly around **player/border collisions**.  

Challenges tackled:

1. **Player-centered movement:** The player sprite stays centered while the map moves behind it.  
2. **Edge collision detection:** Preventing the map from moving when the player collides with a border, while maintaining smooth movement across multiple border tiles.  
   - Implemented **edge detection with counters** rather than simple booleans for robust collision handling.  
3. **Sprite animations:** Running frame-based loops for walking and battle moves.  
4. **Physics tracking:** Detecting when the player enters “dark grass” areas to trigger encounters.  

Most rewarding: Bringing childhood dreams to life by building a game.

---

## 🛠️ What I Learned

- Translating game logic from JS/Canvas to Swift/SpriteKit  
- Handling collision physics for tile-based movement  
- Implementing turn-based battle systems with animation  
- Combining **SwiftUI** and **SpriteKit** for a full game experience  
- Programmatic game development without relying on scene editors  

---

## 🚀 Future Improvements

- Add more monsters and moves  
- Refine animations and transitions  
- Introduce NPCs, inventory systems, or additional maps  

---

## ⚠️ Disclaimer

This project is a **fan-made, educational project**. All Pokémon-related sprites and assets were provided by the tutorial and are not owned by me. This project is not affiliated with or endorsed by Nintendo, Game Freak, or The Pokémon Company.

---


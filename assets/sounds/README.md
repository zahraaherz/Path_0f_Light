# Sound Assets

This folder contains sound effects for the enhanced quiz system.

## Required Sound Files

Place the following MP3 files in this directory:

### Quiz Feedback Sounds
- `correct.mp3` - Plays when answer is correct (pleasant, positive sound)
- `wrong.mp3` - Plays when answer is wrong (gentle negative sound)
- `success.mp3` - Plays on quiz completion or achievement
- `levelup.mp3` - Plays when user levels up
- `streak.mp3` - Plays on streak milestones (3, 5, 10, etc.)

### UI Sounds
- `tap.mp3` - Plays on button/option selection
- `tick.mp3` - Plays during timer countdown (last 5 seconds)

### Background Music (Optional)
- `bg_music.mp3` - Gentle background music during quiz (optional)

## Where to Get Sounds

### Free Resources:
1. **Freesound.org** - https://freesound.org
2. **Zapsplat** - https://www.zapsplat.com
3. **Mixkit** - https://mixkit.co/free-sound-effects

### Recommendations:
- Use short sounds (< 1 second for feedback)
- Keep file sizes small (< 100KB each)
- Use 128kbps MP3 encoding
- Ensure sounds are not jarring or loud
- Test on actual devices

## Example Sound Specifications

```
correct.mp3:
- Duration: 0.5s
- Type: Bell chime or pleasant ding
- Volume: Medium

wrong.mp3:
- Duration: 0.3s
- Type: Gentle buzz or low tone
- Volume: Medium-low

success.mp3:
- Duration: 1-2s
- Type: Celebration sound
- Volume: Medium-high

tap.mp3:
- Duration: 0.1s
- Type: Soft click
- Volume: Low
```

## Alternative: Use Default Sounds

If you don't have custom sounds, the app will gracefully handle missing files and continue to work without audio feedback. The `AudioService` includes error handling.

## Testing

Test all sounds on:
- iOS devices
- Android devices
- Different volume levels
- With/without headphones

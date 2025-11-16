# Friends System & Book Reading Features - Implementation Plan

## Overview
This document outlines the implementation plan for:
1. Friends System with search and connections
2. Native Book Reading Experience with comments and customization
3. Reading gamification with energy rewards

---

## 1. Database Schema

### Firestore Collections

#### `friends` Collection
```
friends/{userId}/
  ├── friends/{friendId}
  │   ├── userId: string
  │   ├── friendId: string
  │   ├── status: 'pending' | 'accepted' | 'blocked'
  │   ├── requestedBy: string (userId who sent request)
  │   ├── createdAt: timestamp
  │   ├── acceptedAt: timestamp?
  │   └── lastInteraction: timestamp
  │
  └── metadata/
      ├── totalFriends: number
      ├── pendingRequests: number
      └── blockedUsers: number
```

#### `userCodes` Collection (for search)
```
userCodes/{userCode}
  ├── userId: string
  ├── username: string
  ├── displayName: string
  ├── photoURL: string?
  ├── createdAt: timestamp
  └── isActive: boolean
```

#### `bookComments` Collection
```
bookComments/{commentId}
  ├── id: string
  ├── bookId: string
  ├── paragraphId: string
  ├── userId: string
  ├── username: string
  ├── userPhoto: string?
  ├── text: string
  ├── isPrivate: boolean
  ├── likes: number
  ├── likedBy: string[] (userIds)
  ├── replies: number
  ├── parentCommentId: string? (for replies)
  ├── createdAt: timestamp
  ├── updatedAt: timestamp
  └── reported: boolean
```

#### `paragraphReports` Collection
```
paragraphReports/{reportId}
  ├── id: string
  ├── bookId: string
  ├── paragraphId: string
  ├── userId: string
  ├── issueType: string (typo, wrong_content, formatting, other)
  ├── description: string
  ├── status: 'pending' | 'reviewed' | 'resolved' | 'dismissed'
  ├── createdAt: timestamp
  └── resolvedAt: timestamp?
```

#### `userBookProgress` Collection
```
userBookProgress/{userId}/books/{bookId}
  ├── bookId: string
  ├── currentParagraphId: string
  ├── currentPage: number
  ├── totalPagesRead: number
  ├── progressPercentage: number
  ├── lastReadAt: timestamp
  ├── startedAt: timestamp
  ├── completedAt: timestamp?
  ├── energyEarned: number
  └── readingStreak: number
```

#### `userBookmarks` Collection
```
userBookmarks/{userId}/bookmarks/{bookmarkId}
  ├── id: string
  ├── bookId: string
  ├── paragraphId: string
  ├── pageNumber: number
  ├── note: string?
  ├── createdAt: timestamp
  └── color: string (for bookmark colors)
```

#### `userBookCollections` Collection
```
userBookCollections/{userId}/collections/{collectionId}
  ├── id: string
  ├── name: string
  ├── description: string
  ├── bookIds: string[]
  ├── isPublic: boolean
  ├── createdAt: timestamp
  └── updatedAt: timestamp
```

#### `readingPreferences` (stored in userProfile)
```
readingPreferences:
  ├── fontSize: 'small' | 'medium' | 'large' | 'xlarge'
  ├── fontFamily: 'amiri' | 'scheherazade' | 'noto-naskh' | 'traditional'
  ├── backgroundColor: 'white' | 'sepia' | 'dark' | 'black'
  ├── lineSpacing: number (1.0 - 2.0)
  ├── textAlign: 'justified' | 'right' | 'left'
  └── autoScroll: boolean
```

---

## 2. Firebase Functions (Backend)

### Friends Functions
- `searchUsers(query: string)` - Search by username/user code
- `sendFriendRequest(targetUserId: string)`
- `acceptFriendRequest(requestId: string)`
- `rejectFriendRequest(requestId: string)`
- `removeFriend(friendId: string)`
- `blockUser(userId: string)`
- `getFriendsList(userId: string)`
- `getPendingRequests(userId: string)`

### Book Reading Functions
- `getBookContent(bookId: string)`
- `saveReadingProgress(bookId, paragraphId, pageNumber)`
- `createBookmark(bookId, paragraphId, note?)`
- `deleteBookmark(bookmarkId)`
- `addToCollection(bookId, collectionId?)`
- `removeFromCollection(bookId, collectionId)`
- `downloadBook(bookId)` - Returns PDF URL

### Comment Functions
- `createComment(bookId, paragraphId, text, isPrivate)`
- `updateComment(commentId, text)`
- `deleteComment(commentId)`
- `likeComment(commentId)`
- `unlikeComment(commentId)`
- `replyToComment(commentId, text)`
- `getComments(paragraphId, includePrivate)`
- `reportParagraph(bookId, paragraphId, issueType, description)`

### Energy Reward Functions
- `awardReadingEnergy(userId, action: 'paragraph' | 'section' | 'book' | 'comment')`
- `getReadingStats(userId)`
- `updateReadingStreak(userId)`

---

## 3. Flutter Models

### Friend Models
```dart
class FriendRequest
class Friend
class UserSearchResult
```

### Book Reading Models
```dart
class BookComment
class CommentReply
class ParagraphReport
class BookProgress
class UserBookmark
class ReadingPreferences
class BookCollection
```

---

## 4. Flutter UI Screens

### Friends System
- **FriendsScreen** - Main friends page with tabs
  - Friends List tab
  - Pending Requests tab
  - Search tab
- **UserSearchScreen** - Search by code/username
- **FriendProfileScreen** - View friend's profile
- **SendRequestDialog** - Confirm friend request

### Book Reading System
- **LibraryScreen** - Browse all books
- **BookReaderScreen** - Main native reading interface
- **TableOfContentsSheet** - Book sections/chapters
- **ReadingSettingsSheet** - Font, background, size customization
- **BookmarksList** - User's bookmarks for current book
- **CommentsSheet** - View/add comments on paragraph
- **CommentReplyScreen** - Reply thread
- **ReportParagraphDialog** - Report issues
- **BookDetailsScreen** - About book, download, collection
- **BookCollectionsScreen** - Manage collections

---

## 5. Features Breakdown

### Friends Page Features
✅ Search by user code (unique 6-8 char code)
✅ Search by username
✅ Send friend requests
✅ Accept/reject requests
✅ View friends list
✅ Remove friends
✅ Block users
✅ See friend's reading activity (if public)

### Book Reader Features
✅ Native scrolling interface (NOT PDF viewer)
✅ Paragraph-based rendering
✅ Bookmark current position
✅ Manual bookmarks with notes
✅ Comment on paragraphs (private/public)
✅ Like comments
✅ Reply to comments (Instagram-style threading)
✅ Delete own comments
✅ Report paragraph issues
✅ Font size: Small, Medium, Large, XLarge
✅ Font family: Amiri, Scheherazade, Noto Naskh, Traditional
✅ Background: White, Sepia, Dark, Black
✅ Line spacing adjustment
✅ Table of contents (sections navigation)
✅ Progress bar (% complete)
✅ About book section
✅ Download PDF option
✅ Add to collections
✅ AI Text-to-Speech (using Flutter TTS)
✅ Auto-scroll mode

### Comment System (Instagram-style)
✅ Public comments visible to all
✅ Private comments only visible to user
✅ Like/unlike comments
✅ Reply to comments
✅ Nested replies (1 level)
✅ Delete own comments
✅ Edit comments (within 5 minutes)
✅ Report inappropriate comments
✅ Anonymous users can read but not comment
✅ Login prompt for anonymous users

### Gamification
✅ Energy rewards for reading
✅ Reading streaks
✅ Progress tracking
✅ Achievements for books completed
✅ Leaderboard integration

---

## 6. Implementation Order

### Phase 1: Database & Backend (Priority 1)
1. ✅ Create Firestore security rules
2. ✅ Implement Friends Firebase Functions
3. ✅ Implement Book Reading Firebase Functions
4. ✅ Implement Comment System Firebase Functions
5. ✅ Add energy reward logic

### Phase 2: Flutter Models & Repositories (Priority 1)
1. ✅ Create friend models
2. ✅ Create book reading models
3. ✅ Create repositories for friends
4. ✅ Create repositories for book reading
5. ✅ Create Riverpod providers

### Phase 3: Friends UI (Priority 2)
1. ✅ Friends list screen
2. ✅ User search
3. ✅ Friend request handling
4. ✅ Friend profile view

### Phase 4: Book Reader UI (Priority 1)
1. ✅ Library screen
2. ✅ Book reader with pagination
3. ✅ Reading settings customization
4. ✅ Table of contents
5. ✅ Bookmark system
6. ✅ Progress tracking

### Phase 5: Comment System UI (Priority 2)
1. ✅ Comment input widget
2. ✅ Comment list widget
3. ✅ Reply threading
4. ✅ Like functionality
5. ✅ Delete/edit actions
6. ✅ Report system

### Phase 6: Additional Features (Priority 3)
1. ✅ Text-to-speech
2. ✅ Download books
3. ✅ Collections management
4. ✅ Reading statistics
5. ✅ Energy rewards integration

---

## 7. Dependencies to Add

```yaml
dependencies:
  # For text-to-speech
  flutter_tts: ^3.8.5

  # For better text rendering
  flutter_markdown: ^0.6.18

  # For PDF download
  path_provider: ^2.1.2
  dio: ^5.4.0

  # For sharing
  share_plus: ^7.2.1

  # For pull to refresh
  pull_to_refresh: ^2.0.0

  # For better list performance
  flutter_sticky_header: ^0.6.5
```

---

## 8. Security Considerations

- ✅ Validate user authentication before all operations
- ✅ Rate limit friend requests (max 10/day)
- ✅ Rate limit comments (max 50/day)
- ✅ Sanitize comment text
- ✅ Block spam/abusive content
- ✅ Privacy settings for user profiles
- ✅ Only allow deleting own comments
- ✅ Moderator review for reports

---

## 9. Performance Optimizations

- ✅ Pagination for book content (load sections on demand)
- ✅ Cache read paragraphs locally
- ✅ Lazy load comments
- ✅ Index frequently queried fields
- ✅ Use Firestore offline persistence
- ✅ Compress images for user profiles
- ✅ CDN for book content

---

## 10. Testing Checklist

### Friends System
- [ ] Search users by code
- [ ] Search users by username
- [ ] Send friend request
- [ ] Accept friend request
- [ ] Reject friend request
- [ ] Remove friend
- [ ] Block user
- [ ] View friends list

### Book Reader
- [ ] Load book content
- [ ] Navigate between paragraphs
- [ ] Save reading progress
- [ ] Create bookmark
- [ ] Delete bookmark
- [ ] Change font size
- [ ] Change background color
- [ ] View table of contents
- [ ] Download book PDF

### Comments
- [ ] Create public comment
- [ ] Create private comment
- [ ] Like comment
- [ ] Reply to comment
- [ ] Delete own comment
- [ ] Report inappropriate content
- [ ] Anonymous user can read
- [ ] Anonymous user prompted to login

---

## Estimated Timeline

- **Phase 1 (Backend)**: 2-3 days
- **Phase 2 (Models)**: 1 day
- **Phase 3 (Friends UI)**: 2 days
- **Phase 4 (Book Reader UI)**: 3-4 days
- **Phase 5 (Comments UI)**: 2 days
- **Phase 6 (Additional Features)**: 2-3 days

**Total**: 12-15 days

---

## Next Steps

1. Start with Firebase Functions for friends system
2. Implement book reading backend
3. Create Flutter models
4. Build Library screen
5. Build Book Reader screen
6. Implement comment system
7. Add gamification rewards
8. Testing & refinement


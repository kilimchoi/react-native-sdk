import {AutomationsDelegate} from './dto/AutomationsDelegate';

interface AutomationsApi {
  /**
   * The Automations delegate is responsible for handling in-app screens and actions when push notification is received.
   * Make sure the method is called before {@link AutomationsApi.handleNotification}.
   *
   * @param delegate the delegate to be notified about Automations events.
   */
  setDelegate(delegate: AutomationsDelegate): void;

  /**
   * Set push token to Qonversion to enable Qonversion push notifications
   *
   * @param token Firebase device token for Android. APNs device token for iOS.
   */
  setNotificationsToken(token: string): void;

  /**
   * Call to handle push notifications sent by Qonversion Automations.
   *
   * @param notificationData notification payload data
   * @returns true when a push notification was received from Qonversion. Otherwise, returns false, so you need to handle the notification yourself
   *
   * @see [Firebase RemoteMessage data](https://pub.dev/documentation/firebase_messaging_platform_interface/latest/firebase_messaging_platform_interface/RemoteMessage/data.html)
   * @see [APNs notification data](https://developer.apple.com/documentation/usernotifications/unnotificationcontent/1649869-userinfo)
   */
  handleNotification(notificationData: Map<String, Object>): Promise<boolean>;

  /**
   * Get parsed custom payload, which you added to the notification in the dashboard
   *
   * @param notificationData notification payload data
   * @returns a map with custom payload from the notification or null if it's not provided.
   */
  getNotificationCustomPayload(notificationData: Map<string, Object>): Promise<Map<string, Object> | null>;

  /**
   * Show the screen using its ID.
   * @param screenId identifier of the screen which must be shown
   * @returns promise to await for completion.
   */
  showScreen(screenId: string): Promise<void>;
}

export default AutomationsApi;

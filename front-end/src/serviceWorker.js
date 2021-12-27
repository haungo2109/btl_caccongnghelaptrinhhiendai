export default function register() {
	if ('serviceWorker' in navigator) {
		window.addEventListener('load', () => {
            console.log("loaded")
			navigator.serviceWorker.ready.then((registration) => {
				console.log('Installed sw');
				const subscribeOptions = {
					userVisibleOnly: true,
					applicationServerKey: urlBase64ToUint8Array(
						'BH3TlCPLPMEJcHie8_cvds-ykD6F7d6s87AofPAXqBAsI5nbFSPxolyTuA0LAE7IlKXEiLUC9en-f75dzGbLJ2o'
					),
				};
				if (Notification.permission !== 'denied') {
					Notification.requestPermission();
				}
				registration.pushManager
					.subscribe(subscribeOptions)
					.then((pushSubscription) => {
						console.log(
							'PushSubscription: ',
							JSON.stringify(pushSubscription)
						);
						return pushSubscription;
					})
					.then((pushSubscription) => {
						const subscriptionObject = {
							endpoint: pushSubscription.endpoint,
							keys: {
								p256dh: pushSubscription.getKeys('p256dh'),
								auth: pushSubscription.getKeys('auth'),
							},
						};

						sendSubscriptionToBackEnd(subscriptionObject);
					});
			});
		});
	}
}

function sendSubscriptionToBackEnd(subscription) {
	return fetch('/webpush/save_information', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify(subscription),
		credentials: 'include',
	})
		.then(function (response) {
			if (!response.ok) {
				throw new Error('Bad status code from server.');
			}

			return response.json();
		})
		.then(function (responseData) {
			if (!(responseData.data && responseData.data.success)) {
				throw new Error('Bad response from server.');
			}
		});
}

function receivePushNotification(event) {
	console.log('[Service Worker] Push Received.');

	const { image, tag, url, title, text } = event.data.json();

	const options = {
		data: url,
		body: text,
		icon: image,
		vibrate: [200, 100, 200],
		tag: tag,
		image: image,
		badge: 'https://spyna.it/icons/favicon.ico',
		actions: [
			{
				action: 'Detail',
				title: 'View',
				icon: 'https://via.placeholder.com/128/ff0000',
			},
		],
	};
	event.waitUntil(window.self.registration.showNotification(title, options));
}

function openPushNotification(event) {
	console.log(
		'[Service Worker] Notification click Received.',
		event.notification.data
	);

	event.notification.close();
	event.waitUntil(window.self.clients.openWindow(event.notification.data));
}

window.self.addEventListener('push', receivePushNotification);
window.self.addEventListener('notificationclick', openPushNotification);

export function unregister() {
	if ('serviceWorker' in navigator) {
		navigator.serviceWorker.ready.then((registration) => {
			registration.unregister();
            console.log("Uninstall SW")
		});
	}
}

function urlBase64ToUint8Array(base64String) {
	var padding = '='.repeat((4 - (base64String.length % 4)) % 4);
	var base64 = (base64String + padding)
		.replace(/\-/g, '+')
		.replace(/_/g, '/');

	var rawData = window.atob(base64);
	var outputArray = new Uint8Array(rawData.length);

	for (var i = 0; i < rawData.length; ++i) {
		outputArray[i] = rawData.charCodeAt(i);
	}
	return outputArray;
}
